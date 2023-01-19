import 'package:test/test.dart';
import 'package:widget_driver_annotation/widget_driver_annotation.dart';

import 'test_helpers/annotation_info_getter.dart';

void main() {
  test('`TestDriverDefaultFutureValue` can be created as a const variable', () {
    const testDriverDefaultFutureValue = TestDriverDefaultFutureValue();
    expect(testDriverDefaultFutureValue.runtimeType, TestDriverDefaultFutureValue);
  });

  test('Can create `TestDriverDefaultFutureValue` with no value (representing void)', () {
    const testDriverDefaultFutureValue = TestDriverDefaultFutureValue();
    expect(testDriverDefaultFutureValue.value, null);
  });

  test('Can create `TestDriverDefaultFutureValue` with some const values', () {
    const boolTestDriverDefaultFutureValue = TestDriverDefaultFutureValue(false);
    expect(boolTestDriverDefaultFutureValue.value, false);

    const stringTestDriverDefaultFutureValue = TestDriverDefaultFutureValue('Some text');
    expect(stringTestDriverDefaultFutureValue.value, 'Some text');
  });

  test('Can annotate a method with `TestDriverDefaultFutureValue` and read out the annotation from the method', () {
    final testClass = _TestClass();
    final annotation =
        AnnotationInfoGetter.getMethodAnnotation<TestDriverDefaultFutureValue<String>>(testClass.someStringMethod);

    expect(annotation, isNotNull);
    expect(annotation!.value, 'Some default string');
  });
}

/// Here we create a class and annotate a method with the `TestDriverDefaultFutureValue`.
/// Then we use this in the unit tests and verify that we can read out this annotation.
class _TestClass {
  @TestDriverDefaultFutureValue('Some default string')
  Future<String> someStringMethod() {
    return Future.value('Some string');
  }
}
