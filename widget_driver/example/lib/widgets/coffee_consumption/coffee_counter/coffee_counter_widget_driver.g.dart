// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_counter_widget_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.2.0"

class _$TestCoffeeCounterWidgetDriver extends TestDriver implements CoffeeCounterWidgetDriver {
  @override
  int get coffeeCount => 123;

  @override
  String get consumeCoffeeQuickButtonText => 'Hello World';

  @override
  String get consumeCoffeeSlowButtonText => 'Hello World';

  @override
  String get resetCoffeeButtonText => 'Hello World';

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void consumeCoffeeQuick() {}

  @override
  Future<bool> consumeCoffeeSlow() {
    return Future.value(true);
  }

  @override
  void resetConsumption() {}

  @override
  void dispose() {}
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
