# WidgetDriver

[![check-code-quality](https://github.com/bmw-tech/widget_driver/actions/workflows/check-code-quality.yml/badge.svg?branch=master)](https://github.com/bmw-tech/widget_driver/actions/workflows/check-code-quality.yml)
[![License](https://img.shields.io/badge/license-MIT-purple.svg)](LICENSE)

A Flutter presentation layer framework,  
which will clean up your widget code, make your widgets more maintainable and easier to test and removes the need to mock thousands of dependencies in your widget tests.  
Let's go driving! 🚙💨

The `WidgetDriver` framework is built up on different dart packages. The core package which contains the actual framework is the `widget_driver`. Then there are some helper packages which support with code generation and making testing easier.

Here is an overview of all the packages:

## widget_driver  [![pub package](https://img.shields.io/pub/v/widget_driver.svg)](https://pub.dev/packages/widget_driver)

- [Source code](widget_driver)

The core package which provides the `WidgetDriver` framework.

Import it into your pubspec `dependencies:` section.

## widget_driver_generator [![pub package](https://img.shields.io/pub/v/widget_driver_generator.svg)](https://pub.dev/packages/widget_driver_generator)

- [Source code](widget_driver_generator)

The package providing generators to automate the creation of your `TestDrivers` and `WidgetDriverProviders`.

Import it into your pubspec `dev_dependencies:` section.

## widget_driver_annotation [![pub package](https://img.shields.io/pub/v/widget_driver_annotation.svg)](https://pub.dev/packages/widget_driver_annotation)

- [Source code](widget_driver_annotation)

The annotation package which has no dependencies.  

You do not need to import this since the `widget_driver` package already imports it for you.  
But if you need/want to import it then import it into your pubspec `dependencies:` section.

## widget_driver_test [![pub package](https://img.shields.io/pub/v/widget_driver_test.svg)](https://pub.dev/packages/widget_driver_test)

- [Source code](widget_driver_test)

Contains helper classes/methods to support with:

- Testing your `DrivableWidgets`
- Testing your `WidgetDrivers`
- Mocking your `TestDrivers`

Import it into your pubspec `dev_dependencies:` section.

## example

- [Source code](widget_driver/example)

A Flutter example app showing how to set up all dependencies and how to use the WidgetDriver framework and how to test your widgets and drivers.

## Contribute

So you're thinking about supporting us and contributing to the WidgetDriver package. That's great 😀

The first step is to read our [contributing guide](CONTRIBUTING.md).

### Helpful commands

`Makefile` file located in the repository root can give you an insight of all available targets which can help you in your development.

Following `Makefile` targets are available in the project:

```bash
all                         Run all steps including building the Android and iOS
build                       Build the example Android and iOS apps from the widget_driver package
build_android               Run the Android build of the example app (located inside `widget_driver/example`) without deploying to any device
build_ios                   Run the iOS build of the example app (located inside `widget_driver/example`) without deploying to any device
clean                       Clean all the cache and dependencies from dart modules.
example_run_build_runner    Generate code for the example app inside the widget_driver folder.
format                      Format all Dart files in the project with the line length set to 120
help                        Show all commands
install                     Fetch all dependencies for all packages
lint                        Run flutter lint in all projects
publish                     publish all projects to pub.dev
quality                     Run only linter and tests
test                        Run all tests in all projects
watch                       Starts the example app and performs the hot reload in case of any change

```

### Publish to pub.dev

To make the plugins accessible, we want to publish them to pub.dev. [publish_all_packages.yml](.github/workflows/publish_all_packages.yml) contains a job that deploys all four plugins to pub.dev. This job is named `Publish all packages to pub.dev` and is triggered manually. If you want to check first if it's safe to publish the plugins, you can run `dart pub publish --dry-run` in the root of each plugin.  
