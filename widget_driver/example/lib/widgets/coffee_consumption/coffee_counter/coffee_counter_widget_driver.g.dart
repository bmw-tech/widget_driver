// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_counter_widget_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

/// You can use this typedef as a base class for your DrivableWidget
///
/// ```dart
/// class MyCustomWidget extends $CoffeeCounterDrivableWidget {
///     ...
/// }
/// ```
typedef $CoffeeCounterDrivableWidget = DrivableWidget<CoffeeCounterWidgetDriver,
    $CoffeeCounterWidgetDriverProvider>;

class _$TestCoffeeCounterWidgetDriver extends TestDriver
    implements CoffeeCounterWidgetDriver {
  @override
  String get descriptionText => 'Consumed coffees';

  @override
  String get amountText => '3';

  @override
  String get consumeCoffeeButtonText => 'Consume coffee';

  @override
  String get resetCoffeeButtonText => 'Reset consumption';

  @override
  void consumeCoffee() {}

  @override
  void resetConsumption() {}
}

class $CoffeeCounterWidgetDriverProvider
    extends WidgetDriverProvider<CoffeeCounterWidgetDriver> {
  @override
  CoffeeCounterWidgetDriver buildDriver(BuildContext context) {
    return CoffeeCounterWidgetDriver(context);
  }

  @override
  CoffeeCounterWidgetDriver buildTestDriver() {
    return _$TestCoffeeCounterWidgetDriver();
  }
}
