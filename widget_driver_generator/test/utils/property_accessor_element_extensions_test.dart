import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widget_driver_generator/src/utils/property_accessor_element_extensions.dart';

class MockPropertyAccessorElement extends Mock implements PropertyAccessorElement {}

void main() {
  group('PropertyAccessorElementExtension:', () {
    group('isRedundantToFieldElement:', () {
      test('returns true for a synthetic (implicit) PropertyAccessorElement', () {
        final sut = MockPropertyAccessorElement();
        when(() => sut.isSynthetic).thenReturn(true);
        expect(sut.isRedundantToFieldElement, isTrue);
      });

      test('returns false for a non-synthetic (explicit) PropertyAccessorElement', () {
        final sut = MockPropertyAccessorElement();
        when(() => sut.isSynthetic).thenReturn(false);
        expect(sut.isRedundantToFieldElement, isFalse);
      });
    });
  });
}
