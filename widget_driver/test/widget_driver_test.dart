import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver/widget_driver.dart';

// ignore: avoid_relative_lib_imports
import '../../widget_driver_test/lib/widget_driver_test.dart';

void main() {
  group('WidgetDriver:', () {
    group('Updating:', () {
      testWidgets('Never calling notifyWidget never triggers listener to emit', (WidgetTester tester) async {
        int numberOfDriverListenersEmits = 0;

        final driverTester = await tester.getDriverTester(
          driverBuilder: (context) => _ConcreteWidgetDriver(context),
        );
        final driver = driverTester.driver;
        driver.addListener(() {
          numberOfDriverListenersEmits += 1;
        });

        await driverTester.verifyNoMoreCallsToNotifyWidget();

        expect(numberOfDriverListenersEmits, equals(0));
      });

      testWidgets('Calling notifyWidget once triggers listener to emit once', (WidgetTester tester) async {
        int numberOfDriverListenersEmits = 0;

        final driverTester = await tester.getDriverTester(
          driverBuilder: (context) => _ConcreteWidgetDriver(context),
        );
        final driver = driverTester.driver;
        driver.addListener(() {
          numberOfDriverListenersEmits += 1;
        });

        driver.notifyWidget();
        await driverTester.waitForNotifyWidget();
        await driverTester.verifyNoMoreCallsToNotifyWidget();

        expect(numberOfDriverListenersEmits, equals(1));
      });

      testWidgets('Calling notifyWidget three times triggers listener to emit three times',
          (WidgetTester tester) async {
        int numberOfDriverListenersEmits = 0;

        final driverTester = await tester.getDriverTester(
          driverBuilder: (context) => _ConcreteWidgetDriver(context),
        );
        final driver = driverTester.driver;
        driver.addListener(() {
          numberOfDriverListenersEmits += 1;
        });

        driver.notifyWidget();
        driver.notifyWidget();
        driver.notifyWidget();

        await driverTester.waitForNotifyWidget(numberOfCalls: 3);
        await driverTester.verifyNoMoreCallsToNotifyWidget();

        expect(numberOfDriverListenersEmits, equals(3));
      });
    });

    group('Lifecycle:', () {
      testWidgets('Calls dispose when driver gets deallocated',
          (WidgetTester tester) async {
        bool disposeWasCalled = false;

        final driverTester = await tester.getDriverTester(
          driverBuilder: (context) => _ConcreteWidgetDriver(context),
        );
        final driver = driverTester.driver;
        driver.disposedCallback = () {
          disposeWasCalled = true;
        };

        // Here we put a new widget in the test-screen.
        // This will remove the widget which contains our
        await tester.pumpWidget(const SizedBox.shrink());

        expect(disposeWasCalled, true);
      });

      testWidgets(
          'Does not call dispose when the driver never gets deallocated',
          (WidgetTester tester) async {
        bool disposeWasCalled = false;

        final driverTester = await tester.getDriverTester(
          driverBuilder: (context) => _ConcreteWidgetDriver(context),
        );
        final driver = driverTester.driver;
        driver.disposedCallback = () {
          disposeWasCalled = true;
        };

        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        expect(disposeWasCalled, false);
      });
    });
  });

  group('TestDriver Base Class:', () {
    test('Adding listener and calling `notifyWidget` does nothing', () async {
      final testDriver = _ConcreteTestDriver();
      bool addListenerWasCalled = false;
      testDriver.addListener(() {
        addListenerWasCalled = true;
      });
      testDriver.notifyWidget();
      await Future.delayed(const Duration(milliseconds: 200));
      expect(addListenerWasCalled, false);
    });

    testWidgets('Does not call dispose when driver gets deallocated',
        (WidgetTester tester) async {
      bool disposeWasCalled = false;

      final driverTester = await tester.getDriverTester(
        driverBuilder: (context) => _ConcreteTestDriver(),
      );
      final driver = driverTester.driver;
      driver.disposedCallback = () {
        disposeWasCalled = true;
      };

      // Here we put a new widget in the test-screen.
      // This will remove the widget which contains our
      await tester.pumpWidget(const SizedBox.shrink());

      expect(disposeWasCalled, false);
    });

    testWidgets('Calling function with no placeholder implementation throws',
        (WidgetTester tester) async {
      bool didThrowNoSuchMethodError = false;
      final driverTester = await tester.getDriverTester(
        driverBuilder: (context) => _ConcreteTestDriver(),
      );
      final driver = driverTester.driver;
      try {
        driver.someEmptyFunction();
      } on NoSuchMethodError {
        didThrowNoSuchMethodError = true;
      }
      expect(didThrowNoSuchMethodError, true);
    });
  });
}

/// A concrete implementation of the abstract `WidgetDriver`.
/// Since the `WidgetDriver` is abstract, we cannot create an instance of it.
/// To be able to create an instance of the driver which we can use for testing,
/// we create a `ConcreteWidgetDriver` which is only used in these tests.
class _ConcreteWidgetDriver extends WidgetDriver {
  VoidCallback? disposedCallback;

  _ConcreteWidgetDriver(BuildContext context) : super(context);

  void someEmptyFunction() {}

  @override
  void dispose() {
    if (disposedCallback != null) {
      disposedCallback!();
    }
    super.dispose();
  }
}

class _ConcreteTestDriver extends TestDriver implements _ConcreteWidgetDriver {
  @override
  VoidCallback? disposedCallback;
}
