// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.0.3"

class _$TestHomePageDriver extends TestDriver implements HomePageDriver {
  @override
  String get title => 'Coffee Demo App';

  @override
  int get numberOfTabs => 2;

  @override
  List<AppTabType> get appTabs => [AppTabType.consumption, AppTabType.community];
}

class $HomePageDriverProvider extends WidgetDriverProvider<HomePageDriver> {
  @override
  HomePageDriver buildDriver() {
    return HomePageDriver();
  }

  @override
  HomePageDriver buildTestDriver() {
    return _$TestHomePageDriver();
  }
}
