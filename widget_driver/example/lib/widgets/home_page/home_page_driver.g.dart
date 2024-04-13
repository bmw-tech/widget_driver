// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.2.0"

class _$TestHomePageDriver extends TestDriver implements HomePageDriver {
  @override
  String get title => 'Hello World';

  @override
  int get numberOfTabs => 123;

  @override
  List<AppTabType> get appTabs => [];

  @override
  void didUpdateBuildContext(BuildContext context) {}
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
