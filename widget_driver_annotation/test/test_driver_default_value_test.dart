import 'package:test/test.dart';
import 'package:widget_driver_annotation/widget_driver_annotation.dart';

import 'test_helpers/annotation_info_getter.dart';

void main() {
  test('`TestDriverDefaultValue` can be created as a const variable', () {
    const testDriverDefaultValue = TestDriverDefaultValue();
    expect(testDriverDefaultValue.runtimeType, TestDriverDefaultValue);
  });

  test('Can create `TestDriverDefaultValue` with no value (representing void)', () {
    const testDriverDefaultValue = TestDriverDefaultValue();
    expect(testDriverDefaultValue.value, null);
  });

  test('Can create `TestDriverDefaultValue` with some const values', () {
    const boolTestDriverDefaultValue = TestDriverDefaultValue(false);
    expect(boolTestDriverDefaultValue.value, false);

    const stringTestDriverDefaultValue = TestDriverDefaultValue('Some text');
    expect(stringTestDriverDefaultValue.value, 'Some text');
  });

  test('Can annotate a method with `TestDriverDefaultValue` and read out the annotation from the method', () {
    final testClass = _TestClass();
    final annotation =
        AnnotationInfoGetter.getMethodAnnotation<TestDriverDefaultValue<String>>(testClass.someStringMethod);

    expect(annotation, isNotNull);
    expect(annotation!.value, 'Some default string');
  });
}

/// Here we create a class and annotate a method with the `TestDriverDefaultValue`.
/// Then we use this in the unit tests and verify that we can read out this annotation.
class _TestClass {
  @TestDriverDefaultValue('Some default string')
  String someStringMethod() {
    return 'Some string';
  }
}
