// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'not_logged_in_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.2.0"

class _$TestNotLoggedInPageDriver extends TestDriver implements NotLoggedInPageDriver {
  @override
  String get notLoggedInText => 'Hello World';

  @override
  String get registerNewAccountButtonText => 'Hello World';

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void registerNewAccountTapped(BuildContext context) {}
}

class $NotLoggedInPageDriverProvider extends WidgetDriverProvider<NotLoggedInPageDriver> {
  @override
  NotLoggedInPageDriver buildDriver() {
    return NotLoggedInPageDriver();
  }

  @override
  NotLoggedInPageDriver buildTestDriver() {
    return _$TestNotLoggedInPageDriver();
  }
}
