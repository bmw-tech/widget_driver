// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_app_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// This file was generated with widget_driver_generator version: 1.0.0+1

class _$TestMyAppDriver extends TestDriver implements MyAppDriver {
  @override
  String get appTitle => 'Coffee Demo App';
}

class $MyAppDriverProvider extends WidgetDriverProvider<MyAppDriver> {
  @override
  MyAppDriver buildDriver(BuildContext context) {
    return MyAppDriver(context);
  }

  @override
  MyAppDriver buildTestDriver() {
    return _$TestMyAppDriver();
  }
}
