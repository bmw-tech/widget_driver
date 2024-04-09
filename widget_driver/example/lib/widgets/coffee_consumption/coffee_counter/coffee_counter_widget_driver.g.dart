// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_counter_widget_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.0.3"

class _$TestCoffeeCounterWidgetDriver extends TestDriver implements CoffeeCounterWidgetDriver {
  @override
  int get coffeeCount => 0;

  @override
  String get consumeCoffeeQuickButtonText => ' ';

  @override
  String get consumeCoffeeSlowButtonText => ' ';

  @override
  String get resetCoffeeButtonText => ' ';

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void consumeCoffeeQuick() {}

  @override
  Future<bool> consumeCoffeeSlow() {
    return Future.value(false);
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
