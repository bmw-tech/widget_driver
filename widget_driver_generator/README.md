<div align="center">
  <img src="https://github.com/bmw-tech/widget_driver/blob/master/widget_driver/doc/resources/widget_driver_logo.png?raw=true" width="180">
</div>
<br>
<div align="center">

[![pub package](https://img.shields.io/pub/v/widget_driver_generator.svg)](https://pub.dev/packages/widget_driver_generator)
[![check-code-quality](https://github.com/bmw-tech/widget_driver/actions/workflows/check-code-quality.yml/badge.svg?branch=master)](https://github.com/bmw-tech/widget_driver/actions/workflows/check-code-quality.yml)
[![License](https://img.shields.io/badge/license-MIT-purple.svg)](LICENSE)

</div>

`widget_driver_generator` is a helper package that supports the `widget_driver` package and generates the bootstrapping code needed to get your `Drivers` fully set up.

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

After you have organized your import statements it is time to define your `Driver`. At this point you also need to annotate your `Driver` class with the `GenerateTestDriver()` annotation. If you forget to do this, then you will not get any generated code.

```dart
@GenerateTestDriver()
class MyDriver extends WidgetDriver {
  ...
}
```

Now there is just one step missing. Any public properties and methods in your `Driver` can be annotated so they provide a specific value in tests. Simple return types like all of [Dart's built-in types](https://dart.dev/language/built-in-types), enums, Optionals and some frequently used types in widgets like `Color`, `IconData` and `FontWeight` are already covered. More complex type, like your custom classes, must be covered in your code.

Annotate the properties you want to explicitly define in the `TestDriver` with `TestDriverDefaultValue({default_value})`. As a parameter to the `TestDriverDefaultValue` you pass in the default value which you want the driver to give to the widget when the widget is being tested.

You can also annotate your methods with `TestDriverDefaultValue({default_return_value})`. As a parameter to the `TestDriverDefaultValue` you pass in the default value which you want the driver to return to the widget when the widget calls this method during tests. If the method does not return anything, then just pass nothing as a parameter.
If you method returns a future, then you can use the `TestDriverDefaultFutureValue` annotation instead. It will correctly generate a future with the return value you pass into it.

```dart
@GenerateTestDriver()
class MyDriver extends WidgetDriver {
  ...

  int get value => _someService.value;

  @TestDriverDefaultValue(CustomClass())
  CustomClass get value => _counterService.getCustomClass;

  void doSomething() {
    ...
  }

  String giveMeSomeString() {
    return _someService.getSomeString();
  }

  Future<int> giveMeSomeIntSoon() {
    return _someService.getSomeIntSoon();
  }

  @TestDriverDefaultFutureValue(CustomClass())
  Future<CustomClass> giveMeSomeCustomClassSoon() {
  return _someService.getSomeCustomClassSoon();
  }
}
```

#### (Optional) Specify global test default values

As an alternative to annotating test default values you can also globally specify what values should be generated for a type inside your `build.yaml`. This will load your specified values into the table where default values are taken from.

What's important is that you have to specify how they will be constructed, not something like a json version of the class. Note here, how the CustomClass is specified. Make sure though that the drivers for which the class will be generated are aware of all classes used in the constructor, otherwise you'll get a compiler error.

Add the `build.yaml` on the level of your `pubspec.yaml` in the following scheme:
```yaml
targets:
  $default:
    builders:
      widget_driver_generator:
        options:
          defaultTestValues:
            "bool": "true"
            "Color": "Colors.yellow"
            "int": "123"
            "CustomClass": "const CustomClass(\n    name: 'name',\n    description: 'Some desc',\n    imageUrl: 'http://www.exampleImage.com/image',\n  )"
            "String": "'Hello World'"
```

This can help you in multiple situations. The above example does two things:
1. It overwrites values for already specified built-in and frequently used types (bool, Color, int, String). This is not needed to make the generation work without adding annotations though, it's more a 'nice to have''.
2. It specifies the value for a CustomClass. This one would not have been generated without annotations. By specifying it here, you can omit the annotation for the class in all of your drivers.

### Generating the code

So now you have all of your imports, definitions and annotations in place.  
Then let's do a one-time build:

```console
dart run build_runner build --delete-conflicting-outputs
```

Read more about using
[`build_runner` on pub.dev](https://pub.dev/packages/build_runner).

## Intro to WidgetDriver

For more information about the `widget_driver` framework then please read [here](../widget_driver)