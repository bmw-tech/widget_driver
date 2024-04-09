import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/element/element.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widget_driver_generator/src/utils/field_element_extensions.dart';

class MockFieldElement extends Mock implements FieldElement {}

class MockPropertyAccessorElementImplImplicitSetter extends Mock
    implements PropertyAccessorElementImpl_ImplicitSetter {}

class MockPropertyAccessorElementImplImplicitGetter extends Mock
    implements PropertyAccessorElementImpl_ImplicitGetter {}

void main() {
  group('FieldElementExtension: isRedundantToPropertyAccessorElement', () {
    test('returns false for a FieldElement with implicit setter and getter (aka variable field)', () {
      final sut = MockFieldElement();
      when(() => sut.setter).thenReturn(MockPropertyAccessorElementImplImplicitSetter());
      when(() => sut.getter).thenReturn(MockPropertyAccessorElementImplImplicitGetter());
      expect(sut.isRedundantToPropertyAccessorElement, isFalse);
    });

    test('returns false for a FieldElement with implicit getter (aka final field)', () {
      final sut = MockFieldElement();
      when(() => sut.getter).thenReturn(MockPropertyAccessorElementImplImplicitGetter());
      expect(sut.isRedundantToPropertyAccessorElement, isFalse);
    });

    test('returns true for a FieldElement with neither implicit setter nor getter (aka property)', () {
      final sut = MockFieldElement();
      expect(sut.isRedundantToPropertyAccessorElement, isTrue);
    });
  });
}
