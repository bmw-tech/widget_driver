// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_library_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

class _$TestCoffeeLibraryPageDriver extends TestDriver
    implements CoffeeLibraryPageDriver {
  @override
  int get numberOfCoffees => 10;

  @override
  Coffee getCoffeeAtIndex(int index) {
    return _testCoffee;
  }
}

class $CoffeeLibraryPageDriverProvider
    extends WidgetDriverProvider<CoffeeLibraryPageDriver> {
  @override
  CoffeeLibraryPageDriver buildDriver() {
    return CoffeeLibraryPageDriver();
  }

  @override
  CoffeeLibraryPageDriver buildTestDriver() {
    return _$TestCoffeeLibraryPageDriver();
  }
}

typedef $CoffeeLibraryPageDrivableWidget
    = DrivableWidget<CoffeeLibraryPageDriver, $CoffeeLibraryPageDriverProvider>;
