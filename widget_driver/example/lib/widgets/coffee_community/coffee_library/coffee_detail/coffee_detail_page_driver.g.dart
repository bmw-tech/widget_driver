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
  /// This function allows you to react to changes of the `driverProvidableProperties` in the driver.
  ///
  /// These properties are coming to the driver from the widget, and in Flutter, the widgets get recreated often.
  /// But the driver does not get recreated for each widget creation. The drivers lifecycle is similar to that of a state.
  /// That means that your driver constructor is not called when a new widget is created.
  /// So the driver constructor does not get a chance to read any potential changes of the properties in the widget.
  ///
  /// Important, you do not need to call `notifyWidget()` in this method.
  /// This method is called right before the build method of the DrivableWidget.
  /// Thus all data changed here will be shown with the "currently ongoing render cycle".
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
