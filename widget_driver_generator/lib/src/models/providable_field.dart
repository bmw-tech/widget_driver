import 'package:analyzer/dart/element/element.dart';
import 'package:widget_driver_generator/src/utils/import_prefix_resolver.dart';
import 'package:widget_driver_generator/src/utils/string_extensions.dart';

/// Class representing a field annotated with the `@driverProvidableModel` annotation, to keep track of all the
/// important data to generate fields, constructors and parameters.
class ProvidableField {
  final String name;
  final String type;
  final bool isRequired;
  final String? defaultValueCode;
  final bool isNamed;

  const ProvidableField({
    required this.name,
    required this.type,
    required this.isRequired,
    required this.isNamed,
    this.defaultValueCode,
  });

  factory ProvidableField.fromParameterElement(
    ParameterElement param, {
    ImportPrefixResolver importPrefixResolver = const ImportPrefixResolver(),
  }) {
    final rawType = param.type.toString().replaceFirst('*', '');
    final library = param.library;
    final type = library == null
        ? rawType
        : importPrefixResolver.applyPrefixes(code: rawType, types: [param.type], library: library);
    return ProvidableField(
      name: param.name.removeLeadingUnderscore(),
      type: type,
      isRequired: param.isRequired,
      defaultValueCode: param.defaultValueCode,
      isNamed: param.isNamed,
    );
  }
}
