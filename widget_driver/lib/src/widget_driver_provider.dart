import 'widget_driver.dart';

/// This is a factory which knows how to create `Drivers`.
///
/// The WidgetDriver framework will use these to create the correct type of Drivers.
/// E.g. when you are running tests then the TestDrivers will be created.
/// And when running the real app then the real Driver gets created.
abstract class WidgetDriverProvider<Driver extends WidgetDriver> {
  /// Creates and returns the `Driver` with the real business logic.
  Driver buildDriver();

  /// Creates and returns the `Driver` with the hard coded test values.
  Driver buildTestDriver();

  /// This method only get's overridden when the driver has provided properties.
  /// It calls a method in the driver, added by the `_$DriverProvidedProperties` interface,
  /// to respond to properties changed during a state update.
  /// Therefore it is called in the scope of the build method,
  /// shortly before the widget gets actually built.
  /// (The driver does not get rebuilt for state updates!)
  void updateDriverProvidedProperties(Driver driver) {}
}
