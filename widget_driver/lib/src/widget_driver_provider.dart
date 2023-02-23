import 'package:flutter/material.dart';

import 'widget_driver.dart';

/// This is a factory which knows how to create `Drivers`.
///
/// The WidgetDriver framework will use these to create the correct type of Drivers.
/// E.g. when you are running tests then the TestDrivers will be created.
/// And when running the real app then the real Driver gets created.
abstract class WidgetDriverProvider<Driver extends WidgetDriver> {
  /// Creates and returns the `Driver` with the real business logic.
  Driver buildDriver(BuildContext context);

  /// Creates and returns the `Driver` with the hard coded test values.
  Driver buildTestDriver();

  /// This function only get's overriden when the driver has provided properties.
  /// It calls a function in the driver, added by the `[SomeDriver]ProvidedPropertiesMixin`,
  /// to respond to properties changed during a state update.
  /// (The driver does not get rebuilt for state updates!)
  void updateProvidedProperties(Driver driver) {}
}
