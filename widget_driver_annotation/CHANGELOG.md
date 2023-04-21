# CHANGELOG

## 1.0.0

* No changes. Just the official release of WidgetDriverAnnotations :-D

## 0.0.4

* Adds new annotation to support passing data from the widget to the driver

## 0.0.3

* Breaking change: Removes old annotation -> `Driver`, `DriverProperty`, `DriverAction`.  
Replaces them with more descriptive annotations -> `GenerateTestDriver`, `TestDriverDefaultValue`.
* Adds support for having annotations which generate code returning `Futures`  
For that, use the new `TestDriverDefaultFutureValue`

## 0.0.2

* Adds example markdown file for pub.dev to give basic information about how to use the annotations.

## 0.0.1

* Initial release.
* Adds annotations for `Driver`, `DriverProperties` and `DriverActions`.
