import 'package:widget_driver/widget_driver.dart';

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
