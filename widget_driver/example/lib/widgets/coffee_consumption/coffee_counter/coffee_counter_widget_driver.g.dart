// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_counter_widget_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

class _$TestCoffeeCounterWidgetDriver extends TestDriver
    implements CoffeeCounterWidgetDriver {
  @override
  String get amountText => "3";

  @override
  String descriptionText = "Consumed coffees";

  @override
  String consumeCoffeeButtonText = "Consume coffee";

  @override
  String resetCoffeeButtonText = "Reset consumption";

  @override
  void consumeCoffee() {}

  @override
  void resetConsumption() {}
}

class $CoffeeCounterWidgetDriverProvider
    extends WidgetDriverProvider<CoffeeCounterWidgetDriver> {
  @override
  CoffeeCounterWidgetDriver buildDriver() {
    return CoffeeCounterWidgetDriver();
  }

  @override
  CoffeeCounterWidgetDriver buildTestDriver() {
    return _$TestCoffeeCounterWidgetDriver();
  }
}

typedef $CoffeeCounterDrivableWidget = DrivableWidget<CoffeeCounterWidgetDriver,
    $CoffeeCounterWidgetDriverProvider>;
