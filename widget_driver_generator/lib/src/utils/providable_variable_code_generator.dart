import 'package:widget_driver_generator/src/utils/code_writer.dart';
import 'package:widget_driver_generator/src/utils/providable_field.dart';
import 'package:widget_driver_generator/src/utils/source_code_generator.dart';

/// This class can generate string based code.
class ProvidableVariableCodeGenerator {
  final List<ProvidableField> _fields;
  final List<ProvidableField> _namedFields;
  final List<ProvidableField> _positionalFields;
  final String _providerClassName;

  ProvidableVariableCodeGenerator({
    required List<ProvidableField> fields,
    required String providerClassName,
  })  : _namedFields = fields.where((element) => element.isNamed).toList(),
        _positionalFields = fields.where((element) => !element.isNamed).toList(),
        _fields = fields,
        _providerClassName = providerClassName;

  /// Generates private and final fields provided in the constructor.
  /// e.g.:
  /// ```dart
  /// final Type _providedVariable;
  /// ```
  String generateFields() {
    final StringBuffer buffer = StringBuffer();
    for (final variable in _fields) {
      buffer.writeln('final ${variable.type} _${variable.name};');
    }

    if (_fields.isNotEmpty) {
      buffer.writeln(SourceCodeGenerator.getEmptyLineCode());
    }
    return buffer.toString();
  }

  /// Generates the constructor that initializes all the `fields` provided in the constructor of this class.
  /// All of this fields will be generated as named parameters and be required, depending on the `required` field
  /// in the `fields` list.
  /// e.g.:
  /// ```dart
  /// $MyPageDriverProvider({
  ///   required MyClass providedVariable,
  /// }) : _providedVariable = providedVariable;
  /// ```
  String generateConstructor() {
    final StringBuffer fields = StringBuffer();
    final StringBuffer initializer = StringBuffer();

    if (_fields.isNotEmpty) {
      for (final variable in _fields) {
        final requiredString = variable.isRequired ? 'required ' : '';
        final defaultValueCode = variable.defaultValueCode != null ? ' = ${variable.defaultValueCode}' : '';
        fields.writeln('$requiredString${variable.type} ${variable.name}$defaultValueCode,');
      }
      initializer.writeln(_fields.map((e) => '_${e.name} = ${e.name}').join(','));

      return '''
$_providerClassName({
  ${fields.toString()}
}) : ${initializer.toString()};''' +
          SourceCodeGenerator.getEmptyLineCode();
    }
    return '';
  }

  /// Generates the parameter list to be passed to the Driver in the `buildDriver` method, containing all the
  /// provided, named and positional fields.
  String generateParameters() {
    final namedVariables =
        _namedFields.isNotEmpty ? _namedFields.map((e) => '${e.name}: _${e.name}').join(',') + ',' : '';
    final positionalVariables =
        _positionalFields.isNotEmpty ? _positionalFields.map((e) => '_${e.name}').join(',') + ',' : '';
    return ', $positionalVariables $namedVariables';
  }
}
