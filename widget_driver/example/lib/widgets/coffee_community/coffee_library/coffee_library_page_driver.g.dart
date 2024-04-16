// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_library_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.2.0"

class _$TestCoffeeLibraryPageDriver extends TestDriver implements CoffeeLibraryPageDriver {
  @override
  bool get isFetching => true;

  @override
  int get numberOfCoffees => 123;

  @override
  Coffee getCoffeeAtIndex(int index) {
    return const Coffee(
      name: 'Coffee',
      description: 'Some desc',
      imageUrl: 'http://www.exampleImage.com/image',
    );
  }

  @override
  void dispose() {}
}

class $CoffeeLibraryPageDriverProvider extends WidgetDriverProvider<CoffeeLibraryPageDriver> {
  @override
  CoffeeLibraryPageDriver buildDriver() {
    return CoffeeLibraryPageDriver();
  }

  @override
  CoffeeLibraryPageDriver buildTestDriver() {
    return _$TestCoffeeLibraryPageDriver();
  }
}
