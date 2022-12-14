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
  @override
  CoffeeDetailPageDriver buildDriver(BuildContext context) {
    return CoffeeDetailPageDriver(context);
  }

  @override
  CoffeeDetailPageDriver buildTestDriver() {
    return _$TestCoffeeDetailPageDriver();
  }
}
