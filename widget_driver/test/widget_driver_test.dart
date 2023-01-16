import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver/widget_driver.dart';

// ignore: avoid_relative_lib_imports
import '../../widget_driver_test/lib/widget_driver_test.dart';

void main() {
  group('WidgetDriver:', () {
    group('Updating:', () {
      testWidgets('Never calling notifyWidget never triggers listener to emit',
          (WidgetTester tester) async {
        int numberOfDriverListenersEmits = 0;

        final driverTester = await tester.getDriverTester(
          driverBuilder: (context) => ConcreteWidgetDriver(context),
        );
        final driver = driverTester.driver;
        driver.addListener(() {
          numberOfDriverListenersEmits += 1;
        });

        await driverTester.verifyNoMoreCallsToNotifyWidget();

        expect(numberOfDriverListenersEmits, equals(0));
      });

      testWidgets('Calling notifyWidget once triggers listener to emit once',
          (WidgetTester tester) async {
        int numberOfDriverListenersEmits = 0;

        final driverTester = await tester.getDriverTester(
          driverBuilder: (context) => ConcreteWidgetDriver(context),
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

      testWidgets(
          'Calling notifyWidget three times triggers listener to emit three times',
          (WidgetTester tester) async {
        int numberOfDriverListenersEmits = 0;

        final driverTester = await tester.getDriverTester(
          driverBuilder: (context) => ConcreteWidgetDriver(context),
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

    /*
      This test cannot run yet since it depends on a new version
      of `widget_driver_test`. But the `widget_driver_test` needs a new 
      version of `widget_driver` before it can be deployed :)

      So the goal is:
      1: Deploy new version of `widget_driver`
      2: Deploy new version of `widget_driver_test`
      3: Add this code back.

    group('Lifecycle:', () {
      testWidgets('Calls dispose when driver gets deallocated', (WidgetTester tester) async {
        bool disposeWasCalled = false;

        final driverTester = await tester.getDriverTester(
          driverBuilder: (context) => ConcreteWidgetDriver(context),
        );
        final driver = driverTester.driver;
        driver.disposedCallback = () {
          disposeWasCalled = true;
        };

        // Here we put a new widget in the test-screen.
        // This will remove the widget which contains our
        /// Change this.. move this into the driverTester.. as a helper function...
        await tester.pumpWidget(const SizedBox.shrink());

        expect(disposeWasCalled, true);
      });
    });
    */
  });
}

/// A concrete implementation of the abstract `WidgetDriver`.
/// Since the `WidgetDriver` is abstract, we cannot create an instance of it.
/// To be able to create an instance of the driver which we can use for testing,
/// we create a `ConcreteWidgetDriver` which is only used in these tests.
class ConcreteWidgetDriver extends WidgetDriver {
  VoidCallback? disposedCallback;

  ConcreteWidgetDriver(BuildContext context) : super(context);

  @override
  void dispose() {
    if (disposedCallback != null) {
      disposedCallback!();
    }
    super.dispose();
  }
}
