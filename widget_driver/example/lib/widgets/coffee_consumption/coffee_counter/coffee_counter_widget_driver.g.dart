// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_counter_widget_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: prefer_const_constructors

// This file was generated with widget_driver_generator version "0.2.1"

class _$TestCoffeeCounterWidgetDriver extends TestDriver implements CoffeeCounterWidgetDriver {
  @override
  ConsumedCoffeesCount get consumedCoffeeCount => ConsumedCoffeesCount(3);

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
  CoffeeCounterWidgetDriver buildDriver(BuildContext context) {
    return CoffeeCounterWidgetDriver(context);
  }

  @override
  CoffeeCounterWidgetDriver buildTestDriver() {
    return _$TestCoffeeCounterWidgetDriver();
  }
}
