// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'not_logged_in_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

/// You can use this typedef as a base class for your DrivableWidget
///
/// ```dart
/// class MyCustomWidget extends $NotLoggedInPageDrivableWidget {
///     ...
/// }
/// ```
typedef $NotLoggedInPageDrivableWidget
    = DrivableWidget<NotLoggedInPageDriver, $NotLoggedInPageDriverProvider>;

class _$TestNotLoggedInPageDriver extends TestDriver
    implements NotLoggedInPageDriver {
  @override
  String get notLoggedInText => 'Not logged in';
}

class $NotLoggedInPageDriverProvider
    extends WidgetDriverProvider<NotLoggedInPageDriver> {
  @override
  NotLoggedInPageDriver buildDriver(BuildContext context) {
    return NotLoggedInPageDriver(context);
  }

  @override
  NotLoggedInPageDriver buildTestDriver() {
    return _$TestNotLoggedInPageDriver();
  }
}
