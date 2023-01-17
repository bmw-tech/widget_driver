import 'package:widget_driver/widget_driver.dart';

/// This driver provider is used by the `TestDrivableWidget`
/// and the helper extension on WidgetTester to make sure that
/// the driver under test is created correctly.
class TestWidgetDriverProvider<T extends WidgetDriver> extends WidgetDriverProvider<T> {
  final T Function(BuildContext context) _driverBuilder;

  TestWidgetDriverProvider({
    required T Function(BuildContext context) driverBuilder,
  }) : _driverBuilder = driverBuilder;

  @override
  T buildDriver(BuildContext context) {
    return _driverBuilder(context);
  }

  @override
  T buildTestDriver() {
    throw UnimplementedError();
  }
}
