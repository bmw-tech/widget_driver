// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_app_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

/// You can use this typedef as a base class for your DrivableWidget
///
/// ```dart
/// class MyCustomWidget extends $MyAppDrivableWidget {
///     ...
/// }
/// ```
typedef $MyAppDrivableWidget
    = DrivableWidget<MyAppDriver, $MyAppDriverProvider>;

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
