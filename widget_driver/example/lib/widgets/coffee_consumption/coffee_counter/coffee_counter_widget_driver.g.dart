// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_counter_widget_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// This file was generated with widget_driver_generator version: 1.0.0+1

class _$TestCoffeeCounterWidgetDriver extends TestDriver implements CoffeeCounterWidgetDriver {
  @override
  String get descriptionText => 'Consumed coffees';

  @override
  String get amountText => '3';

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
    return Future.value(true);
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
