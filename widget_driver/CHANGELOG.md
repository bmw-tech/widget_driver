# CHANGELOG

## 1.0.4

* Adds the WidgetDriver logo to the readme 🥳

## 1.0.3

* Found one more small issue in the example.md file. Now I think I fixed them all :-D

## 1.0.2

* Fixes small issues with missing params for the example-driver in the example.md file.

## 1.0.1

* Adds example/example.md for the example page on pub.dev

## 1.0.0

* The official release of WidgetDriver :-D
* Fixes issue with widgetdriver image in readme.

## 0.4.0

* Updates the README.
* Updates the order in which the DependencyResolver resolves dependencies.
* Removes all TestDriver code creation when running release builds.

## 0.3.0

* Changes name of `DependencyProvider` to `DependencyResolver` and adds support in it for resolving dependencies using the BuildContext.
* Adds a `didInitDriver` method to the driver which is called one time per `Driver` lifecycle after the driver is fully initialized.

## 0.2.0

* Refactors WidgetDriver to no longer get the BuildContext passed into via the constructor.  
Instead the driver now has an optional method called `didUpdateBuildContext` which is called once directly after the constructor. And then this method is called again if any inherited build context dependency did change.

## 0.1.0

* Adds a new method which your drivers are forced to implement. This new method is `didUpdateBuildContextDependencies` and it is called by the framework if your driver has a dependency to an inherited widget from the build context and that dependency updates.

## 0.0.8

* Adds a new helper class `DependencyProvider` to support with creating/resolving dependencies when needed directly into the widget.

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
