// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_first_drivable_widget_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.2.0"

class _$TestMyFirstDrivableWidgetDriver extends TestDriver implements MyFirstDrivableWidgetDriver {
  @override
  String get appBarTitle => 'Hello World';

  @override
  String get counterTitle => 'Hello World';

  @override
  String get counterValue => 'Hello World';

  @override
  IconData get increaseActionIcon => const IconData(0);

  @override
  IconData get resetActionIcon => const IconData(0);

  @override
  void increaseCounterAction() {}

  @override
  void resetCounterAction() {}
}

class $MyFirstDrivableWidgetDriverProvider extends WidgetDriverProvider<MyFirstDrivableWidgetDriver> {
  @override
  MyFirstDrivableWidgetDriver buildDriver() {
    return MyFirstDrivableWidgetDriver();
  }

  @override
  MyFirstDrivableWidgetDriver buildTestDriver() {
    return _$TestMyFirstDrivableWidgetDriver();
  }
}
