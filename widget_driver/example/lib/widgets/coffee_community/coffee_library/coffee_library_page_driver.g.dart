// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_library_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version: 1.0.0+1

class _$TestCoffeeLibraryPageDriver extends TestDriver implements CoffeeLibraryPageDriver {
  @override
  bool get isFetching => false;

  @override
  int get numberOfCoffees => 10;

  @override
  Coffee getCoffeeAtIndex(int index) {
    return TestCoffee.testCoffee;
  }
}

class $CoffeeLibraryPageDriverProvider extends WidgetDriverProvider<CoffeeLibraryPageDriver> {
  @override
  CoffeeLibraryPageDriver buildDriver(BuildContext context) {
    return CoffeeLibraryPageDriver(context);
  }

  @override
  CoffeeLibraryPageDriver buildTestDriver() {
    return _$TestCoffeeLibraryPageDriver();
  }
}
