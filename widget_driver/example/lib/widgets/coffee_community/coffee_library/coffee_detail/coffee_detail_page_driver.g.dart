// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_detail_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// This file was generated with widget_driver_generator version: 1.0.0+1

class _$TestCoffeeDetailPageDriver extends TestDriver implements CoffeeDetailPageDriver {
  @override
  String get coffeeName => TestCoffee.testCoffeeName;

  @override
  String get coffeeDescription => TestCoffee.testCoffeeDescription;

  @override
  String get coffeeImageUrl => TestCoffee.testCoffeeImageUrl;
}

class $CoffeeDetailPageDriverProvider extends WidgetDriverProvider<CoffeeDetailPageDriver> {
  final int _index;
  final Coffee _coffee;

  $CoffeeDetailPageDriverProvider({
    required int index,
    required Coffee coffee,
  })  : _index = index,
        _coffee = coffee;

  @override
  CoffeeDetailPageDriver buildDriver(BuildContext context) {
    return CoffeeDetailPageDriver(
      context,
      _index,
      coffee: _coffee,
    );
  }

  @override
  CoffeeDetailPageDriver buildTestDriver() {
    return _$TestCoffeeDetailPageDriver();
  }
}
