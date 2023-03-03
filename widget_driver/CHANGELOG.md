# CHANGELOG

## 0.0.7

* Fixes issues with ignoring of state changes
* enables new generated mixin from `widget_driver_generator ^0.0.6`

## 0.0.6

* Adds EmptyDefault to ease testDriverValue creation

## 0.0.5

* Updates to use latest version of annotations package which contains the new `driverProvidableProperty` annotations to support passing simple parameters directly into the driver.

## 0.0.4

* Updates documentation to reflect the new driver annotation names.

## 0.0.3

* Removes `FlowCoordinators` since it is currently not used. We will add this back if it ever becomes needed.
* Adds missing unit tests to widget_driver code. Reached 100% test coverage!

## 0.0.2

* Adds unit test for framework code

## 0.0.1

* Initial release.
* Adds support `WidgetDrivers` and `DrivableWidgets`.
* Adds placeholder code for `FlowCoordinators` so that they can be easily added later.
* Adds [Example app](example) which showcases how to use `WidgetDrivers`.
