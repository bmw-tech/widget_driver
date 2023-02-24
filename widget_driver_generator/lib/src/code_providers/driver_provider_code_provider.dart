import 'package:widget_driver_generator/src/utils/class_utils.dart';
import 'package:widget_driver_generator/src/utils/code_writer.dart';
import 'package:widget_driver_generator/src/utils/string_extensions.dart';

import '../models/providable_field.dart';

class DriverProviderCodeProvider {
  final List<ProvidableField> _providedFields;
  final List<ProvidableField> _providedNamedFields;
  final List<ProvidableField> _providedPositionalFields;
  final String _driverClassName;
  final String _providerClassName;
  final String _testDriverClassName;

  DriverProviderCodeProvider({
    required List<ProvidableField> fields,
    required String driverClassName,
  })  : _providedNamedFields = fields.where((element) => element.isNamed).toList(),
        _providedPositionalFields = fields.where((element) => !element.isNamed).toList(),
        _providedFields = fields,
        _driverClassName = driverClassName,
        _providerClassName = ClassUtils.driverProviderClassName(driverClassName),
        _testDriverClassName = ClassUtils.testDriverClassName(driverClassName);

  /// Returns the code of the "DriverProvider" class depending on the provided ProvidableFields list.
  /// E.g:
  /// ```dart
  /// class $ExampleDriverProvider extends WidgetDriverProvider<ExampleDriver> {
  ///   final ExampleModel _example;
  ///
  ///   $CoffeeDetailPageDriverProvider({
  ///     required ExampleModel example,
  ///   }) : _example = example;
  ///
  ///   @override
  ///   CoffeeDetailPageDriver buildDriver(BuildContext context) {
  ///     return CoffeeDetailPageDriver(
  ///       context,
  ///       example: _example,
  ///     );
  ///   }
  ///
  ///   @override
  ///   CoffeeDetailPageDriver buildTestDriver() {
  ///     return _$TestCoffeeDetailPageDriver();
  ///   }
  /// }
  /// ```
  String get driverProviderClass {
    if (_providedFields.isEmpty) {
      return _classWithoutFields();
    } else {
      return _classWithFields();
    }
  }

  /// Generates private and final fields provided in the constructor.
  /// e.g.:
  /// ```dart
  /// final Type _providedVariable;
  /// ```
  String _fields() => _providedFields
      .map(
        (e) => 'final ${e.type} _${e.name};',
      )
      .join('\n');

  /// Generates the constructor parameters for every field in `fields` provided in the constructor of this class.
  /// All of this fields will be generated as named parameters and be required, depending on the `required` field
  /// in the `fields` list.
  /// e.g.:
  /// ```dart
  /// required MyClass providedVariable,
  /// ```
  String _constructorParameters() {
    final CodeWriter fields = CodeWriter();

    for (final variable in _providedFields) {
      final requiredString = variable.isRequired ? 'required ' : '';
      final defaultValueCode = variable.defaultValueCode != null ? ' = ${variable.defaultValueCode}' : '';
      fields.writeCode('$requiredString${variable.type} ${variable.name}$defaultValueCode,');
    }
    return fields.getAllCode();
  }

  /// Generates the initializer for every field in `fields` provided in the constructor of this class.
  /// e.g.:
  /// ```dart
  /// ) : // from the constructor not generated here.
  /// _providableVariable = providableVariable;
  /// ```
  String _constructorInitializer() => _providedFields
      .map(
        (e) => '_${e.name} = ${e.name}',
      )
      .join(',');

  /// Generates the parameter list to be passed to the Driver in the `buildDriver` method, containing all the
  /// provided named and positional fields.
  String _parameters() {
    final namedVariables =
        _providedNamedFields.isNotEmpty ? '${_providedNamedFields.map((e) => '${e.name}: _${e.name}').join(',')},' : '';
    final positionalVariables =
        _providedPositionalFields.isNotEmpty ? '${_providedPositionalFields.map((e) => '_${e.name}').join(',')},' : '';
    return ', $positionalVariables $namedVariables';
  }

  String _updateParameters() {
    return _providedFields.map((e) => '${e.name.makeItNew()}: _${e.name}').join(',');
  }

  /// Generates a DriverProvider-class, if there are no provided variables.
  String _classWithoutFields() => '''
class $_providerClassName extends WidgetDriverProvider<$_driverClassName> {
  @override
  $_driverClassName buildDriver(BuildContext context) {
    return $_driverClassName(context);
  }

  @override
  $_driverClassName buildTestDriver() {
    return $_testDriverClassName();
  }
}
''';

  /// Generates a DriverProvider-class, if there are provided variables.
  String _classWithFields() => '''
class $_providerClassName extends WidgetDriverProvider<$_driverClassName> {
  ${_fields()}

  $_providerClassName({
    ${_constructorParameters()}
  }) : ${_constructorInitializer()};

  @override
  $_driverClassName buildDriver(BuildContext context) {
    return $_driverClassName(context ${_parameters()});
  }

  @override
  $_driverClassName buildTestDriver() {
    return $_testDriverClassName();
  }

  @override
  void updateDriverProvidedProperties($_driverClassName driver) {

    //  In case you get a compiler error here, you have to mixin ${ClassUtils.providedPropertiesMixinClassName()} into your driver.
    //  And implement updateDriverProvidedProperties(), there you can react to new values to all your provided values.
    //  Like this:
    //  class $_driverClassName extends WidgetDriver with ${ClassUtils.providedPropertiesMixinClassName()} {
    //    
    //    ...
    //
    //    @override
    //    void updateDriverProvidedProperties(...) {
    //      // Handle your updates
    //    }
    //  }
    driver.updateDriverProvidedProperties(${_updateParameters()},);
  }
}
''';
}
