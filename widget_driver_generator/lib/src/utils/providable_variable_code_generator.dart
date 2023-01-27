import 'package:widget_driver_generator/src/utils/code_writer.dart';
import 'package:widget_driver_generator/src/utils/providable_field.dart';
import 'package:widget_driver_generator/src/utils/source_code_generator.dart';

/// This class can generate string based code.
class ProvidableVariableCodeGenerator {
  final CodeWriter _codeWriter;
  final List<ProvidableField> _fields;
  final List<ProvidableField> _namedFields;
  final List<ProvidableField> _positionalFields;
  final String _providerClassName;

  ProvidableVariableCodeGenerator({
    required CodeWriter codeWriter,
    required List<ProvidableField> fields,
    required String providerClassName,
  })  : _codeWriter = codeWriter,
        _namedFields = fields.where((element) => element.isNamed).toList(),
        _positionalFields = fields.where((element) => !element.isNamed).toList(),
        _fields = fields,
        _providerClassName = providerClassName;

  /// Generates private and final fields provided in the constructor and writes those to the provided `codeWriter`.
  /// e.g.:
  /// ```dart
  /// final Type _providedVariable;
  /// ```
  void generateFields() {
    for (final variable in _fields) {
      _codeWriter.writeCode('final ${variable.type} _${variable.name};');
    }

    if (_fields.isNotEmpty) {
      _codeWriter.writeCode(SourceCodeGenerator.getEmptyLineCode());
    }
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
  void generateConstructor() {
    if (_fields.isNotEmpty) {
      _codeWriter.writeCode('$_providerClassName({');
      for (final variable in _fields) {
        final requiredString = variable.isRequired ? 'required ' : '';
        final defaultValueCode = variable.defaultValueCode != null ? ' = ${variable.defaultValueCode}' : '';
        _codeWriter.writeCode('$requiredString${variable.type} ${variable.name}$defaultValueCode,');
      }
      _codeWriter.writeCode('}) :');
      _codeWriter.writeCode(_fields.map((e) => '_${e.name} = ${e.name}').join(',') + ';');
      _codeWriter.writeCode(SourceCodeGenerator.getEmptyLineCode());
    }
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
