// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_first_drivable_widget_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.0.0"

class _$TestMyFirstDrivableWidgetDriver extends TestDriver implements MyFirstDrivableWidgetDriver {
  @override
  String get appBarTitle => 'The app bar title';

  @override
  String get counterTitle => 'Counter:';

  @override
  String get counterValue => '0';

  @override
  IconData get increaseActionIcon => Icons.add;

  @override
  IconData get resetActionIcon => Icons.restore;

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
