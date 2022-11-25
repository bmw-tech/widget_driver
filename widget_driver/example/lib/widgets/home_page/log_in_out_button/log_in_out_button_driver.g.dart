// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_in_out_button_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

/// You can use this typedef as a base class for your DrivableWidget
///
/// ```dart
/// class MyCustomWidget extends $LogInOutButtonDrivableWidget {
///     ...
/// }
/// ```
typedef $LogInOutButtonDrivableWidget
    = DrivableWidget<LogInOutButtonDriver, $LogInOutButtonDriverProvider>;

class _$TestLogInOutButtonDriver extends TestDriver
    implements LogInOutButtonDriver {
  @override
  String get buttonText => 'Log in';

  @override
  void toggleLogInOut() {}
}

class $LogInOutButtonDriverProvider
    extends WidgetDriverProvider<LogInOutButtonDriver> {
  @override
  LogInOutButtonDriver buildDriver(BuildContext context) {
    return LogInOutButtonDriver(context);
  }

  @override
  LogInOutButtonDriver buildTestDriver() {
    return _$TestLogInOutButtonDriver();
  }
}
