# WidgetDriver

Provides a MVVM-style presentation layer framework for Flutter which can `drive` your `widgets`. 🚙💨

**NOTE: This package is still in BETA.**

## widget_driver

- [Source code](widget_driver)

The core package which provides the WidgetDriver framework.

Import it into your pubspec `dependencies:` section.

## widget_driver_generator

- [Source code](widget_driver_generator)

The package providing generators to automate the creation of your TestDrivers.

Import it into your pubspec `dev_dependencies:` section.

## widget_driver_annotation

- [Source code](widget_driver_annotation)

The annotation package which has no dependencies.  

You do not need to import this since the `widget_driver` package already imports it for you.  
But if you need/want to import it then import it into your pubspec `dependencies:` section.

## widget_driver_test

- [Source code](widget_driver_test)

Contains helper classes to support with mocking your TestDrivers.

Import it into your pubspec `dev_dependencies:` section.

## example

- [Source code](widget_driver/example)

A Flutter example app showing how to set up all dependencies and how to use the WidgetDriver framework.
