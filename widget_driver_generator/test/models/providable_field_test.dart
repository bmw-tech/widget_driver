import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widget_driver_generator/src/models/providable_field.dart';

class MockFormalParameterElement extends Mock implements FormalParameterElement {}

class MockLibraryElement extends Mock implements LibraryElement {}

class MockLibraryFragment extends Mock implements LibraryFragment {}

class MockLibraryImport extends Mock implements LibraryImport {}

class MockPrefixFragment extends Mock implements PrefixFragment {}

class MockPrefixElement extends Mock implements PrefixElement {}

class MockElement extends Mock implements Element {}

// Mocktail's Mock can't stub `toString()`, but that's what ImportPrefixResolver reads the raw type
// name from, so this fake implements DartType directly (like `element.toString()` in production).
class FakeDartType implements DartType {
  const FakeDartType(this._typeName, this.element);

  final String _typeName;

  @override
  final Element element;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  String toString() => _typeName;
}

void main() {
  group('ProvidableField.fromParameterElement:', () {
    test('keeps the import alias for a parameter type imported with a prefix', () {
      final typeLibrary = MockLibraryElement();
      final contextLibrary = MockLibraryElement();

      final typeElement = MockElement();
      when(() => typeElement.name).thenReturn('SomeClass');
      when(() => typeElement.library).thenReturn(typeLibrary);

      final type = FakeDartType('SomeClass', typeElement);

      final prefixElement = MockPrefixElement();
      when(() => prefixElement.name).thenReturn('foo');
      final prefixFragment = MockPrefixFragment();
      when(() => prefixFragment.element).thenReturn(prefixElement);

      final import = MockLibraryImport();
      when(() => import.importedLibrary).thenReturn(typeLibrary);
      when(() => import.prefix).thenReturn(prefixFragment);

      final fragment = MockLibraryFragment();
      when(() => fragment.libraryImports).thenReturn([import]);
      when(() => contextLibrary.firstFragment).thenReturn(fragment);

      final param = MockFormalParameterElement();
      when(() => param.type).thenReturn(type);
      when(() => param.library).thenReturn(contextLibrary);
      when(() => param.name).thenReturn('someParam');
      when(() => param.isRequired).thenReturn(true);
      when(() => param.isNamed).thenReturn(false);
      when(() => param.defaultValueCode).thenReturn(null);

      final field = ProvidableField.fromParameterElement(param);

      expect(field.type, 'foo.SomeClass');
      expect(field.name, 'someParam');
    });

    test('does not add a prefix if the parameter type was imported without an alias', () {
      final typeLibrary = MockLibraryElement();
      final contextLibrary = MockLibraryElement();

      final typeElement = MockElement();
      when(() => typeElement.name).thenReturn('SomeClass');
      when(() => typeElement.library).thenReturn(typeLibrary);

      final type = FakeDartType('SomeClass', typeElement);

      final import = MockLibraryImport();
      when(() => import.importedLibrary).thenReturn(typeLibrary);
      when(() => import.prefix).thenReturn(null);

      final fragment = MockLibraryFragment();
      when(() => fragment.libraryImports).thenReturn([import]);
      when(() => contextLibrary.firstFragment).thenReturn(fragment);

      final param = MockFormalParameterElement();
      when(() => param.type).thenReturn(type);
      when(() => param.library).thenReturn(contextLibrary);
      when(() => param.name).thenReturn('someParam');
      when(() => param.isRequired).thenReturn(true);
      when(() => param.isNamed).thenReturn(false);
      when(() => param.defaultValueCode).thenReturn(null);

      final field = ProvidableField.fromParameterElement(param);

      expect(field.type, 'SomeClass');
    });
  });
}
