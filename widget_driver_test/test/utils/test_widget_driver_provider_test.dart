import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:widget_driver_test/src/utils/test_widget_driver_provider.dart';

class MockWidgetDriver extends WidgetDriver {}

void main() {
  group('TestWidgetDriverProvider:', () {
    group('When build driver is called', () {
      test('Should return proper driver', () {
        final provider = TestWidgetDriverProvider<MockWidgetDriver>(
          driverBuilder: () => MockWidgetDriver(),
        );

        final driver = provider.buildDriver();

        expect(driver, isA<MockWidgetDriver>());
      });
    });

    group('When build test driver is called', () {
      test('Should throw UnimplementedError', () {
        final provider = TestWidgetDriverProvider<MockWidgetDriver>(
          driverBuilder: () => MockWidgetDriver(),
        );

        expect(() => provider.buildTestDriver(), throwsUnimplementedError);
      });
    });
  });
}
