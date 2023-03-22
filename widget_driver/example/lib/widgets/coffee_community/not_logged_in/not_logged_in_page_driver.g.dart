// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'not_logged_in_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: prefer_const_constructors

// This file was generated with widget_driver_generator version "0.2.1"

class _$TestNotLoggedInPageDriver extends TestDriver implements NotLoggedInPageDriver {
  @override
  String get notLoggedInText => 'Not logged in';

  @override
  String get registerNewAccountButtonText => 'Register a new account';

  @override
  void registerNewAccountTapped(BuildContext context) {}
}

class $NotLoggedInPageDriverProvider extends WidgetDriverProvider<NotLoggedInPageDriver> {
  @override
  NotLoggedInPageDriver buildDriver(BuildContext context) {
    return NotLoggedInPageDriver(context);
  }

  @override
  NotLoggedInPageDriver buildTestDriver() {
    return _$TestNotLoggedInPageDriver();
  }
}
