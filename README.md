# WidgetDriver

A Flutter presentation layer framework, which will clean up your  
widget code and make your widgets testable without a need for thousands of mock objects.  
Let's go driving! 🚙💨

The `WidgetDriver` framework is built up on different dart packages. The core package which contains the actual framework is the `widget_driver`. Then there are some helper packages which support with code generation and making testing easier.

Here is an overview of all the packages:

## widget_driver

- [Source code](widget_driver)

The core package which provides the `WidgetDriver` framework.

Import it into your pubspec `dependencies:` section.

## widget_driver_generator

- [Source code](widget_driver_generator)

The package providing generators to automate the creation of your `TestDrivers` and `WidgetDriverProviders`.

Import it into your pubspec `dev_dependencies:` section.

## widget_driver_annotation

- [Source code](widget_driver_annotation)

The annotation package which has no dependencies.  

You do not need to import this since the `widget_driver` package already imports it for you.  
But if you need/want to import it then import it into your pubspec `dependencies:` section.

## widget_driver_test

- [Source code](widget_driver_test)

Contains helper classes/methods to support with:

- Testing your `DrivableWidgets`
- Testing your `WidgetDrivers`
- Mocking your `TestDrivers`

Import it into your pubspec `dev_dependencies:` section.

## example

- [Source code](widget_driver/example)

A Flutter example app showing how to set up all dependencies and how to use the WidgetDriver framework and how to test your widgets and drivers.
