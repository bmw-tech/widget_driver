// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_in_out_button_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

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
  LogInOutButtonDriver buildDriver() {
    return LogInOutButtonDriver();
  }

  @override
  LogInOutButtonDriver buildTestDriver() {
    return _$TestLogInOutButtonDriver();
  }
}

typedef $LogInOutButtonDrivableWidget
    = DrivableWidget<LogInOutButtonDriver, $LogInOutButtonDriverProvider>;
