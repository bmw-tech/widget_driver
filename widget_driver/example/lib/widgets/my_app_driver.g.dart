// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_app_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: prefer_const_constructors

// This file was generated with widget_driver_generator version "0.2.1"

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
