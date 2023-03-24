import 'package:widget_driver/widget_driver.dart';

/// This driver provider is used by the `TestDrivableWidget`
/// and the helper extension on WidgetTester to make sure that
/// the driver under test is created correctly.
class TestWidgetDriverProvider<T extends WidgetDriver> extends WidgetDriverProvider<T> {
  final T Function() _driverBuilder;

  TestWidgetDriverProvider({
    required T Function() driverBuilder,
  }) : _driverBuilder = driverBuilder;

  @override
  T buildDriver() {
    return _driverBuilder();
  }

  @override
  T buildTestDriver() {
    throw UnimplementedError();
  }
}
