import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:widget_driver_test/src/utils/test_widget_driver_provider.dart';

class MockWidgetDriver extends WidgetDriver {}

void main() {
  group('when build driver is called', () {
    test('should return proper driver', () {
      final provider = TestWidgetDriverProvider<MockWidgetDriver>(
        driverBuilder: () => MockWidgetDriver(),
      );

      final driver = provider.buildDriver();

      expect(driver, isA<MockWidgetDriver>());
    });
  });

  group('when build test driver is called', () {
    test('should throw UnimplementedError', () {
      final provider = TestWidgetDriverProvider<MockWidgetDriver>(
        driverBuilder: () => MockWidgetDriver(),
      );

      expect(() => provider.buildTestDriver(), throwsUnimplementedError);
    });
  });
}
