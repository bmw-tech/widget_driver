import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widget_driver_generator/src/utils/field_element_extensions.dart';

class MockFieldElement extends Mock implements FieldElement {}

class MockSetterElement extends Mock implements SetterElement {}

class MockGetterElement extends Mock implements GetterElement {}

void main() {
  group('FieldElementExtension: isRedundantToPropertyAccessorElement', () {
    test('returns false for a FieldElement with implicit setter and getter (aka variable field)', () {
      final sut = MockFieldElement();
      final setter = MockSetterElement();
      final getter = MockGetterElement();
      when(() => setter.isSynthetic).thenReturn(true);
      when(() => getter.isSynthetic).thenReturn(true);
      when(() => sut.setter).thenReturn(setter);
      when(() => sut.getter).thenReturn(getter);
      expect(sut.isRedundantToPropertyAccessorElement, isFalse);
    });

    test('returns false for a FieldElement with implicit getter (aka final field)', () {
      final sut = MockFieldElement();
      final getter = MockGetterElement();
      when(() => getter.isSynthetic).thenReturn(true);
      when(() => sut.getter).thenReturn(getter);
      expect(sut.isRedundantToPropertyAccessorElement, isFalse);
    });

    test('returns true for a FieldElement with neither implicit setter nor getter (aka property)', () {
      final sut = MockFieldElement();
      expect(sut.isRedundantToPropertyAccessorElement, isTrue);
    });
  });
}
