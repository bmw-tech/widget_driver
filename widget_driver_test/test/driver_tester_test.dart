import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:widget_driver_test/src/driver_tester.dart';

class MockWidgetDriver extends WidgetDriver {
  void triggerNotifyWidgets() {
    notifyWidget();
  }
}

void main() {
  late MockWidgetDriver mockDriver;

  setUp(() {
    mockDriver = MockWidgetDriver();
  });

  group('DriverTester:', () {
    testWidgets('Should wait for notifyWidget call', (WidgetTester tester) async {
      final driverTester = DriverTester(mockDriver, tester);
      Future<void> testFuture = driverTester.waitForNotifyWidget();

      mockDriver.triggerNotifyWidgets();

      await testFuture;
    });

    testWidgets('Should verify no more calls to notifyWidget', (WidgetTester tester) async {
      final driverTester = DriverTester(mockDriver, tester);

      mockDriver.triggerNotifyWidgets();
      await driverTester.waitForNotifyWidget();
      await driverTester.verifyNoMoreCallsToNotifyWidget(timeout: const Duration(milliseconds: 100));
    });

    testWidgets('Should wait for exact number of notifyWidget calls', (WidgetTester tester) async {
      final driverTester = DriverTester(mockDriver, tester);

      Future<void> testFuture = driverTester.waitForNotifyWidget(numberOfCalls: 2, requireExactNumberOfCalls: true);

      mockDriver.triggerNotifyWidgets();
      mockDriver.triggerNotifyWidgets();

      await testFuture;
    });
  });
}
