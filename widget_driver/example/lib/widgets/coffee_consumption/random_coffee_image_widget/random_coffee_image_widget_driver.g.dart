// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_coffee_image_widget_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "0.0.7"

class _$TestRandomCoffeeImageWidgetDriver extends TestDriver implements RandomCoffeeImageWidgetDriver {
  @override
  String get coffeeImageUrl => TestCoffee.testCoffeeImageUrl;

  @override
  String get title => 'Tap image to load a new one';

  @override
  void updateRandomImage() {}
}

class $RandomCoffeeImageWidgetDriverProvider extends WidgetDriverProvider<RandomCoffeeImageWidgetDriver> {
  @override
  RandomCoffeeImageWidgetDriver buildDriver(BuildContext context) {
    return RandomCoffeeImageWidgetDriver(context);
  }

  @override
  RandomCoffeeImageWidgetDriver buildTestDriver() {
    return _$TestRandomCoffeeImageWidgetDriver();
  }
}
