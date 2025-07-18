# CHANGELOG

## 1.3.6

- Fixes bug with code generation in child packages using dart 3.6.2

## 1.3.5

- Updating mocktail to 1.0.4

## 1.3.3

- Remove unnecessary '= null' from property code generation

## 1.3.2

- Fixes bug where the generator generates code for static fields/methods/accessors.

## 1.3.1

- Fixes bug where the "void" keyword was unnecessarily added to setters.

## 1.3.0

- Introduces the option to specify formatter line length in build.yaml.

## 1.2.1

- Fixes bug when no build.yaml is provided.

## 1.2.0

- Introduces the option to specify default values for types in your build.yaml.

## 1.1.0

- Introduces predefined default values for frequently used types to minimize the need of annotations.
- Fixes a bug that allows the generation of setters.

## 1.0.3

- Updates images in readme to look more "snappy" 😁

## 1.0.2

- Adds SDK constraint to 3.0.0.

## 1.0.1

- Adds the WidgetDriver logo to the readme 🥳

## 1.0.0

- No changes. Just the official release of WidgetDriverGenerator :-D

## 0.4.0

- Updates the README.
- Specified minimum versions to some pubspec dependencies.

## 0.3.0

- Updates generator to be compatible with latest api changes in version 0.2.0 of widget_driver.

## 0.2.0

- Changes the name of the generated method for driver provided properties. It used to be `updateDriverProvidedProperties`, now it is called `didUpdateProvidedProperties` to fit better with the name of the method which is called when a build context dependency triggers the driver to update.

## 0.1.0

- Changes the generated code for provided properties to use `implements` and abstract class instead of mixins.
- Fixes the issue where the version number of the generator in the generated file was wrong.

## 0.0.6

- Adds generating of `_$DriverProvidedPropertiesMixin` which fixes ignoring of state issues

## 0.0.5

- Adds `coverage:ignore-file` to generated files to make the code coverage tool ignore these.

## 0.0.4

- Uses the new `@driverProvidableProperty` annotation in the widget_driver_annotation package to generate code in the `DriverProvider`, to pass data from the widget to the driver.
- Refactors the generator classes for more readable and decoupled code.

## 0.0.3

- Updates generator to be compatible with new annotations in the widget_driver_annotation package.
- Refactors generator code to be more testable and decoupled.
- Adds unit tests for code generation.
- Updates README and Example/README to reflect new changes to annotations.

## 0.0.2

- Adds example markdown file for pub.dev to give basic information about how to use the widget_driver_generator.

## 0.0.1

- Initial release.
- Adds possibility to generate code for `TestDrivers` and `WidgetProviders`.
