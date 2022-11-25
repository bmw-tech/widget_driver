// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_library_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

/// You can use this typedef as a base class for your DrivableWidget
///
/// ```dart
/// class MyCustomWidget extends $CoffeeLibraryPageDrivableWidget {
///     ...
/// }
/// ```
typedef $CoffeeLibraryPageDrivableWidget
    = DrivableWidget<CoffeeLibraryPageDriver, $CoffeeLibraryPageDriverProvider>;

class _$TestCoffeeLibraryPageDriver extends TestDriver
    implements CoffeeLibraryPageDriver {
  @override
  bool get isFetching => false;

  @override
  int get numberOfCoffees => 10;

  @override
  Coffee getCoffeeAtIndex(int index) {
    return TestCoffee.testCoffee;
  }
}

class $CoffeeLibraryPageDriverProvider
    extends WidgetDriverProvider<CoffeeLibraryPageDriver> {
  @override
  CoffeeLibraryPageDriver buildDriver(BuildContext context) {
    return CoffeeLibraryPageDriver(context);
  }

  @override
  CoffeeLibraryPageDriver buildTestDriver() {
    return _$TestCoffeeLibraryPageDriver();
  }
}
