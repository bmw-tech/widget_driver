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
  void updateDriverProvidedProperties(CoffeeDetailPageDriver driver) {
    //  In case you get a compiler error here, you have to mixin _$DriverProvidedPropertiesMixin into your driver.
    //  And implement updateDriverProvidedProperties(), there you can react to new values to all your provided values.
    //  Like this:
    //  class CoffeeDetailPageDriver extends WidgetDriver with _$DriverProvidedPropertiesMixin {
    //
    //    ...
    //
    //    @override
    //    void updateDriverProvidedProperties(...) {
    //      // Handle your updates
    //    }
    //  }
    driver.updateDriverProvidedProperties(
      newIndex: _index,
      newCoffee: _coffee,
    );
  }
}

mixin _$DriverProvidedPropertiesMixin {
  /// This function allows you to react to state changes in the driver.
  /// It provides you with the new values to the properties that you passed into the driver.
  /// This is because the driver does not get recreated on state changes.
  /// Important, you do not need to call `notifyWidget()` in this function.
  /// It gets called in the build method of the widget, slightly before rendering.
  /// Thus all data changed here will be shown with the "currently ongoing state change".
  ///
  /// Very Important!!
  /// Because this function is running during the build process,
  /// it is NOT the place to run time cosuming or blocking tasks etc. (like calling Api-Endpoints)
  /// This could greatly impact your apps performance.
  void updateDriverProvidedProperties({
    required int newIndex,
    required Coffee newCoffee,
  });
}
