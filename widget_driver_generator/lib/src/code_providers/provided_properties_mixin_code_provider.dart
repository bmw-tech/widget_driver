import 'package:widget_driver_generator/src/models/providable_field.dart';
import 'package:widget_driver_generator/src/utils/class_utils.dart';
import 'package:widget_driver_generator/src/utils/string_extensions.dart';

class ProvidedPropertiesMixinCodeProvider {
  final List<ProvidableField> _fields;
  final String _providedPropertiesMixinClassName;

  ProvidedPropertiesMixinCodeProvider({
    required List<ProvidableField> fields,
    required String driverClassName,
  })  : _fields = fields,
        _providedPropertiesMixinClassName = ClassUtils.providedPropertiesMixinClassName();

  /// Generates the parameter list for [updateDriverProvidedProperties], as required named parameters.
  String _parameters() => _fields.map((e) => 'required ${e.type} ${e.name.makeItNew()}').join(',');

  /// Returns the code of the `ProvidedPropertiesMixin` class depending on the provided ProvidableFields list.
  /// E.g:
  /// ```dart
  /// class $ExampleDriverProvidedPropertiesMixin {
  ///   void updateDriverProvidedProperties({
  ///     required int newIndex,
  ///     required String newTitle,
  ///   });
  /// }
  /// ```
  String get providedPropertiesMixinClass {
    if (_fields.isEmpty) {
      return '';
    } else {
      return '''
mixin $_providedPropertiesMixinClassName {

  /// This function allows you to react to state changes in the driver. 
  /// It provides you with the new values to the properties that you passed into the driver.
  /// This is because the driver does not get recreated on state changes.
  /// Important, you do not need to call `notifyWidget()` in this function. 
  /// It gets called in the build method of the widget, slightly before rendering. 
  /// Thus all data changed here will be shown with the "currently ongoing state change". 
  /// 
  /// Very Important!!
  /// Because this function is running during the build process, 
  /// it is NOT the place to run time cosuming or blocking tasks etc. (like calling Api-Endpoints)
  /// This could greatly impact your apps performance.
  void updateDriverProvidedProperties({${_parameters()},});
}
''';
    }
  }
}
