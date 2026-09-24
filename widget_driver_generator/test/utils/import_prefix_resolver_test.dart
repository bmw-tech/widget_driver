import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:widget_driver_generator/src/utils/import_prefix_resolver.dart';

class MockLibraryElement extends Mock implements LibraryElement {}

class MockLibraryImportElement extends Mock implements LibraryImportElement {}

class MockImportElementPrefix extends Mock implements ImportElementPrefix {}

class MockPrefixElement extends Mock implements PrefixElement {}

class MockElement extends Mock implements Element {}

class MockDartType extends Mock implements DartType {}

class MockInterfaceType extends Mock implements InterfaceType {}

class MockInterfaceElement extends Mock implements InterfaceElement {}

void main() {
  const sut = ImportPrefixResolver();

  late MockLibraryElement contextLibrary;
  late MockLibraryElement typeLibrary;

  setUp(() {
    contextLibrary = MockLibraryElement();
    typeLibrary = MockLibraryElement();
  });

  MockDartType typeNamed(String name, LibraryElement library) {
    final element = MockElement();
    when(() => element.name).thenReturn(name);
    when(() => element.library).thenReturn(library);
    final type = MockDartType();
    when(() => type.element).thenReturn(element);
    return type;
  }

  MockLibraryImportElement importOf(LibraryElement importedLibrary, {String? prefix}) {
    final import = MockLibraryImportElement();
    when(() => import.importedLibrary).thenReturn(importedLibrary);
    if (prefix == null) {
      when(() => import.prefix).thenReturn(null);
    } else {
      final prefixElement = MockPrefixElement();
      when(() => prefixElement.name).thenReturn(prefix);
      final importPrefix = MockImportElementPrefix();
      when(() => importPrefix.element).thenReturn(prefixElement);
      when(() => import.prefix).thenReturn(importPrefix);
    }
    return import;
  }

  group('ImportPrefixResolver:', () {
    test('adds the alias in front of a type imported with a prefix', () {
      final import = importOf(typeLibrary, prefix: 'foo');
      final type = typeNamed('SomeClass', typeLibrary);
      when(() => contextLibrary.libraryImports).thenReturn([import]);

      final result = sut.applyPrefixes(
        code: 'SomeClass get someGetter',
        types: [type],
        library: contextLibrary,
      );

      expect(result, 'foo.SomeClass get someGetter');
    });

    test('does not change code if the type is declared in the same library', () {
      when(() => contextLibrary.libraryImports).thenReturn([]);
      final type = typeNamed('SomeClass', contextLibrary);

      final result = sut.applyPrefixes(
        code: 'SomeClass get someGetter',
        types: [type],
        library: contextLibrary,
      );

      expect(result, 'SomeClass get someGetter');
    });

    test('does not change code if the import has no prefix', () {
      final import = importOf(typeLibrary);
      final type = typeNamed('SomeClass', typeLibrary);
      when(() => contextLibrary.libraryImports).thenReturn([import]);

      final result = sut.applyPrefixes(
        code: 'SomeClass get someGetter',
        types: [type],
        library: contextLibrary,
      );

      expect(result, 'SomeClass get someGetter');
    });

    test('adds the alias for type arguments of a generic type', () {
      final import = importOf(typeLibrary, prefix: 'foo');
      final typeArgument = typeNamed('SomeClass', typeLibrary);
      final dartCoreLibrary = MockLibraryElement();
      final listElement = MockInterfaceElement();
      when(() => listElement.name).thenReturn('List');
      when(() => listElement.library).thenReturn(dartCoreLibrary);
      final listType = MockInterfaceType();
      when(() => listType.element).thenReturn(listElement);
      when(() => listType.typeArguments).thenReturn([typeArgument]);
      when(() => contextLibrary.libraryImports).thenReturn([import]);

      final result = sut.applyPrefixes(
        code: 'void doSomething(List<SomeClass> list)',
        types: [listType],
        library: contextLibrary,
      );

      expect(result, 'void doSomething(List<foo.SomeClass> list)');
    });

    test('does not re-prefix a name that is already qualified', () {
      final import = importOf(typeLibrary, prefix: 'foo');
      final type = typeNamed('SomeClass', typeLibrary);
      when(() => contextLibrary.libraryImports).thenReturn([import]);

      final result = sut.applyPrefixes(
        code: 'bar.SomeClass get someGetter',
        types: [type],
        library: contextLibrary,
      );

      expect(result, 'bar.SomeClass get someGetter');
    });

    test('does not prefix an occurrence of the type name inside a string literal', () {
      final import = importOf(typeLibrary, prefix: 'foo');
      final type = typeNamed('SomeClass', typeLibrary);
      when(() => contextLibrary.libraryImports).thenReturn([import]);

      final result = sut.applyPrefixes(
        code: "const SomeClass(name: 'SomeClass')",
        types: [type],
        library: contextLibrary,
      );

      expect(result, "const foo.SomeClass(name: 'SomeClass')");
    });
  });
}
