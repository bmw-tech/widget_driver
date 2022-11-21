// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_coffee_image_widget_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

class _$TestRandomCoffeeImageWidgetDriver extends TestDriver
    implements RandomCoffeeImageWidgetDriver {
  @override
  String get coffeeImageUrl => "https://coffee.uaerman.dev/random";

  @override
  void updateRandomImage() {}
}

class $RandomCoffeeImageWidgetDriverProvider
    extends WidgetDriverProvider<RandomCoffeeImageWidgetDriver> {
  @override
  RandomCoffeeImageWidgetDriver buildDriver() {
    return RandomCoffeeImageWidgetDriver();
  }

  @override
  RandomCoffeeImageWidgetDriver buildTestDriver() {
    return _$TestRandomCoffeeImageWidgetDriver();
  }
}

typedef $RandomCoffeeImageDrivableWidget = DrivableWidget<
    RandomCoffeeImageWidgetDriver, $RandomCoffeeImageWidgetDriverProvider>;
