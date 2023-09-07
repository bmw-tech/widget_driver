// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_counter_widget_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.0.2"

class _$TestCoffeeCounterWidgetDriver extends TestDriver implements CoffeeCounterWidgetDriver {
  @override
  int get coffeeCount => 3;

  @override
  String get consumeCoffeeQuickButtonText => 'Consume coffee quick';

  @override
  String get consumeCoffeeSlowButtonText => 'Consume coffee slow';

  @override
  String get resetCoffeeButtonText => 'Reset consumption';

  @override
  void consumeCoffeeQuick() {}

  @override
  Future<bool> consumeCoffeeSlow() {
    return Future.value(false);
  }

  @override
  void resetConsumption() {}
}

class $CoffeeCounterWidgetDriverProvider extends WidgetDriverProvider<CoffeeCounterWidgetDriver> {
  @override
  CoffeeCounterWidgetDriver buildDriver() {
    return CoffeeCounterWidgetDriver();
  }

  @override
  CoffeeCounterWidgetDriver buildTestDriver() {
    return _$TestCoffeeCounterWidgetDriver();
  }
}
