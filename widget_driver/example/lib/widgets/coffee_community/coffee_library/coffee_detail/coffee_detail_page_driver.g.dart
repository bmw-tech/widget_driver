// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_detail_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version: 1.0.0+1

class _$TestCoffeeDetailPageDriver extends TestDriver implements CoffeeDetailPageDriver {
  @override
  String get coffeeName => TestCoffee.testCoffeeName;

  @override
  String get coffeeDescription => TestCoffee.testCoffeeDescription;

  @override
  String get coffeeImageUrl => TestCoffee.testCoffeeImageUrl;
}

class $CoffeeDetailPageDriverProvider extends WidgetDriverProvider<CoffeeDetailPageDriver> {
  final int _index;
  final Coffee _coffee;

  $CoffeeDetailPageDriverProvider({
    required int index,
    required Coffee coffee,
  })  : _index = index,
        _coffee = coffee;

  @override
  CoffeeDetailPageDriver buildDriver(BuildContext context) {
    return CoffeeDetailPageDriver(
      context,
      _index,
      coffee: _coffee,
    );
  }

  @override
  CoffeeDetailPageDriver buildTestDriver() {
    return _$TestCoffeeDetailPageDriver();
  }

  @override
  void updateProvidedProperties(CoffeeDetailPageDriver driver) {
    /* 
      In case you get a compiler error here, you have to mixin [$CoffeeDetailPageDriverProvidedPropertiesMixin] into your driver.
      And implement [updateProvidedProperties()], there you can react to new values to all your provided values.
      Like this:
      class CoffeeDetailPageDriver extends WidgetDriver with [$CoffeeDetailPageDriverProvidedPropertiesMixin] {
        
        ...

        @override
        void updateProvidedProperties(...) {
          // Handle your updates
        }
      }
    */
    driver.updateProvidedProperties(
      newIndex: _index,
      newCoffee: _coffee,
    );
  }
}

mixin $CoffeeDetailPageDriverProvidedPropertiesMixin {
  void updateProvidedProperties({
    required int newIndex,
    required Coffee newCoffee,
  });
}
