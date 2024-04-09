import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/element/element.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widget_driver_generator/src/utils/property_accessor_element_extensions.dart';

class MockPropertyAccessorElement extends Mock implements PropertyAccessorElement {}

class MockPropertyAccessorElementImplImplicitSetter extends Mock
    implements PropertyAccessorElementImpl_ImplicitSetter {}

class MockPropertyAccessorElementImplImplicitGetter extends Mock
    implements PropertyAccessorElementImpl_ImplicitGetter {}

void main() {
  group('PropertyAccessorElementExtension:', () {
    group('isRedundantToFieldElement:', () {
      test('returns false for a PropertyAccessorElementImpl_ImplicitSetter', () {
        final sut = MockPropertyAccessorElementImplImplicitSetter();
        expect(sut.isRedundantToFieldElement, isTrue);
      });

      test('returns false for a PropertyAccessorElementImpl_ImplicitGetter', () {
        final sut = MockPropertyAccessorElementImplImplicitGetter();
        expect(sut.isRedundantToFieldElement, isTrue);
      });

      test('returns false for a PropertyAccessorElement', () {
        final sut = MockPropertyAccessorElement();
        expect(sut.isRedundantToFieldElement, isFalse);
      });
    });
  });
}
