import 'package:test/test.dart';
import 'package:widget_driver_annotation/widget_driver_annotation.dart';

import 'test_helpers/annotation_info_getter.dart';

void main() {
  test('`GenerateTestDriver` can be created as a const variable', () {
    const generateTestDriver = GenerateTestDriver();
    expect(generateTestDriver.runtimeType, GenerateTestDriver);
  });

  test('Can annotate a class with `GenerateTestDriver` and read out the annotation from the class', () {
    final annotation = AnnotationInfoGetter.getClassAnnotation<GenerateTestDriver>(_TestClass);
    expect(annotation, isNotNull);
    expect(annotation.runtimeType, GenerateTestDriver);
  });
}

/// Here we create a class and try to annotate it with the `GenerateTestDriver`.
/// Then we use this in the unit tests and verify that we can read out this annotation from the class.
@GenerateTestDriver()
class _TestClass {}
