import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

/// Rewrites generated code so that types keep the import prefix (alias) they were declared with.
///
/// The analyzer strips import prefixes from `Element.toString()` and `DartType.toString()`, because
/// a prefix is just syntax used by the referencing file and is not part of the type itself. E.g. if a
/// library imports another one with `import '../constants.dart' as foo;` and then declares
/// `foo.SomeClass get someGetter => ...`, the analyzer will report the type as just `SomeClass`.
/// This class re-adds `foo.` in front of `SomeClass`, by looking up the import prefix used for the
/// type's defining library inside the library that declares the inspected element.
class ImportPrefixResolver {
  const ImportPrefixResolver();

  /// Returns [code] with every type in [types] (including their generic type arguments) replaced by
  /// its aliased name, if [library] imports that type's defining library with a prefix.
  /// Occurrences inside string literals (e.g. `'Coffee'` inside a default value like
  /// `Coffee(name: 'Coffee')`) are left untouched.
  String applyPrefixes({
    required String code,
    required List<DartType> types,
    required LibraryElement library,
  }) {
    final prefixesByTypeName = _buildPrefixesByTypeName(types, library);
    if (prefixesByTypeName.isEmpty) {
      return code;
    }
    return _replaceOutsideStringLiterals(code, prefixesByTypeName);
  }

  String _replaceOutsideStringLiterals(String code, Map<String, String> prefixesByTypeName) {
    final result = StringBuffer();
    var codeSegment = StringBuffer();
    var index = 0;
    while (index < code.length) {
      final delimiterLength = _stringDelimiterLengthAt(code, index);
      if (delimiterLength == null) {
        codeSegment.writeCharCode(code.codeUnitAt(index));
        index++;
        continue;
      }

      result.write(_replaceInCode(codeSegment.toString(), prefixesByTypeName));
      codeSegment = StringBuffer();

      final literalStart = index;
      final delimiter = code.substring(index, index + delimiterLength);
      index += delimiterLength;
      while (index < code.length && !code.startsWith(delimiter, index)) {
        // skip escaped characters so an escaped quote doesn't end the literal early.
        index += code.codeUnitAt(index) == _backslash ? 2 : 1;
      }
      final literalEnd = (index + delimiterLength).clamp(0, code.length);
      result.write(code.substring(literalStart, literalEnd));
      index = literalEnd;
    }
    result.write(_replaceInCode(codeSegment.toString(), prefixesByTypeName));
    return result.toString();
  }

  static const _backslash = 0x5C;

  int? _stringDelimiterLengthAt(String code, int index) {
    final char = code.substring(index, index + 1);
    if (char != "'" && char != '"') {
      return null;
    }
    return code.startsWith(char + char + char, index) ? 3 : 1;
  }

  String _replaceInCode(String code, Map<String, String> prefixesByTypeName) {
    var result = code;
    for (final entry in prefixesByTypeName.entries) {
      // Negative lookbehind avoids re-prefixing names that are already qualified or part of a longer identifier.
      final pattern = RegExp('(?<![\\w.])${RegExp.escape(entry.key)}\\b');
      result = result.replaceAll(pattern, entry.value);
    }
    return result;
  }

  Map<String, String> _buildPrefixesByTypeName(List<DartType> types, LibraryElement library) {
    final prefixesByTypeName = <String, String>{};
    for (final type in _flatten(types)) {
      final typeElement = type.element;
      final typeName = typeElement?.name;
      final typeLibrary = typeElement?.library;
      if (typeElement == null || typeName == null || typeLibrary == null || typeLibrary == library) {
        continue;
      }
      final prefix = _findImportPrefix(library, typeLibrary);
      if (prefix != null) {
        prefixesByTypeName[typeName] = '$prefix.$typeName';
      }
    }
    return prefixesByTypeName;
  }

  String? _findImportPrefix(LibraryElement library, LibraryElement typeLibrary) {
    for (final import in library.firstFragment.libraryImports) {
      final prefix = import.prefix;
      if (import.importedLibrary == typeLibrary && prefix != null) {
        return prefix.element.name;
      }
    }
    return null;
  }

  Iterable<DartType> _flatten(List<DartType> types) sync* {
    for (final type in types) {
      yield type;
      if (type is InterfaceType) {
        yield* _flatten(type.typeArguments);
      } else if (type is FunctionType) {
        yield* _flatten([type.returnType, ...type.formalParameters.map((parameter) => parameter.type)]);
      }
    }
  }
}
