// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

/// You can use this typedef as a base class for your DrivableWidget
///
/// ```dart
/// class MyCustomWidget extends $HomePageDrivableWidget {
///     ...
/// }
/// ```
typedef $HomePageDrivableWidget
    = DrivableWidget<HomePageDriver, $HomePageDriverProvider>;

class _$TestHomePageDriver extends TestDriver implements HomePageDriver {
  @override
  String get title => 'Coffee Demo App';

  @override
  int get numberOfTabs => 2;

  @override
  List<AppTabType> get appTabs =>
      [AppTabType.consumption, AppTabType.community];
}

class $HomePageDriverProvider extends WidgetDriverProvider<HomePageDriver> {
  @override
  HomePageDriver buildDriver(BuildContext context) {
    return HomePageDriver(context);
  }

  @override
  HomePageDriver buildTestDriver() {
    return _$TestHomePageDriver();
  }
}
