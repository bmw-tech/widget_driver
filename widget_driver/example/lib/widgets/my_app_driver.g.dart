// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_app_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.2.0"

class _$TestMyAppDriver extends TestDriver implements MyAppDriver {
  @override
  String get appTitle => 'Hello World';

  @override
  void didUpdateBuildContext(BuildContext context) {}
}

class $MyAppDriverProvider extends WidgetDriverProvider<MyAppDriver> {
  @override
  MyAppDriver buildDriver() {
    return MyAppDriver();
  }

  @override
  MyAppDriver buildTestDriver() {
    return _$TestMyAppDriver();
  }
}
