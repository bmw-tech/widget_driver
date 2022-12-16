# WidgetDriver generator

[![pub package](https://img.shields.io/pub/v/widget_driver_generator.svg)](https://pub.dev/packages/widget_driver_generator)
[![check-code-quality](https://github.com/bmw-tech/widget_driver/actions/workflows/check-code-quality.yml/badge.svg?branch=master)](https://github.com/bmw-tech/widget_driver/actions/workflows/check-code-quality.yml)
[![License](https://img.shields.io/badge/license-MIT-purple.svg)](LICENSE)

This is a helper package that supports the `widget_driver` package and generates the bootstrapping code needed to get your `Drivers` fully set up.

---

## Usage

### Dependencies

To use `widget_driver_generator`, you need to have the following dependencies in your `pubspec.yaml`.

```yaml
dependencies:
  # ...along with your other dependencies
  widget_driver: <latest-version>

dev_dependencies:
  # ...along with your other dev-dependencies
  build_runner: <latest-version>
  widget_driver_generator: <latest-version>
```

### Source code

The instructions below explain how to create and annotate your `Drivers` to use this generator.
Along with importing the `widget_driver` package, it's essential to also
include a `part` directive that references the generated Dart file. The generated file will always have the name `[source_file].g.dart`.

```dart
import 'package:widget_driver/widget_driver.dart';

part 'this_file.g.dart';
```

After you have organized your import statements it is time to define your `Driver`. At this point you also need to annotate your `Driver` class with the `Driver()` annotation. If you forget to do this, then you will not get any generated code.

```dart
@Driver()
class MyDriver extends WidgetDriver {
  ...
}
```

Now there is just one thing missing. You need to annotate all public properties and methods in your `Driver` that you want to be able to use in your widgets later.

Annotate the properties with `DriverProperty({default_value})`. As a parameter to the `DriverProperty` you pass in the default value which you want the driver to give to the widget when the widget is being tested.

Annotate the methods with `DriverAction({default_return_value})`. As a parameter to the `DriverAction` you pass in the default value which you want the driver to return to the widget when the widget calls this method during tests. If the method does not return anything, then just pass nothing as a parameter.

```dart
@Driver()
class MyDriver extends WidgetDriver {
  ...

  @DriverProperty(1)
  int get value => _someService.value;

  @DriverAction()
  void doSomething() {
    ...
  }

  @DriverAction('The string')
  String giveMeSomeString() {
    return _someService.getSomeString();
  }
}
```

### Generating the code

So now you have all of your imports, definitions and annotations in place.  
Then let's do a one-time build:

```console
flutter pub run build_runner build
```

Read more about using
[`build_runner` on pub.dev](https://pub.dev/packages/build_runner).

## Intro to WidgetDriver

For more information about the `widget_driver` framework then please read [here](../widget_driver)