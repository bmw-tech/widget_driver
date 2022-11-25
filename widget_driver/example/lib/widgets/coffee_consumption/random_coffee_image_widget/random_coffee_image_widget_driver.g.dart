// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_coffee_image_widget_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

/// You can use this typedef as a base class for your DrivableWidget
///
/// ```dart
/// class MyCustomWidget extends $RandomCoffeeImageDrivableWidget {
///     ...
/// }
/// ```
typedef $RandomCoffeeImageDrivableWidget = DrivableWidget<
    RandomCoffeeImageWidgetDriver, $RandomCoffeeImageWidgetDriverProvider>;

class _$TestRandomCoffeeImageWidgetDriver extends TestDriver
    implements RandomCoffeeImageWidgetDriver {
  @override
  String get coffeeImageUrl => TestCoffee.testCoffeeImageUrl;

  @override
  String get title => 'Tap image to load a new one';

  @override
  void updateRandomImage() {}
}

class $RandomCoffeeImageWidgetDriverProvider
    extends WidgetDriverProvider<RandomCoffeeImageWidgetDriver> {
  @override
  RandomCoffeeImageWidgetDriver buildDriver(BuildContext context) {
    return RandomCoffeeImageWidgetDriver(context);
  }

  @override
  RandomCoffeeImageWidgetDriver buildTestDriver() {
    return _$TestRandomCoffeeImageWidgetDriver();
  }
}
