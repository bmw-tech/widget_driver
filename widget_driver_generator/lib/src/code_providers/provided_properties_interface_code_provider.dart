import 'package:widget_driver_generator/src/models/providable_field.dart';
import 'package:widget_driver_generator/src/utils/string_extensions.dart';

class ProvidedPropertiesInterfaceCodeProvider {
  final List<ProvidableField> _fields;

  ProvidedPropertiesInterfaceCodeProvider({
    required List<ProvidableField> fields,
  }) : _fields = fields;

  /// Generates the parameter list for [updateDriverProvidedProperties], as required named parameters.
  String _parameters() => _fields.map((e) => 'required ${e.type} ${e.name.makeItNew()}').join(',');

  /// Returns the code of the `ProvidedProperties` class depending on the provided ProvidableFields list.
  /// E.g:
  /// ```dart
  /// abstract class _$DriverProvidedProperties {
  ///   void updateDriverProvidedProperties({
  ///     required int newIndex,
  ///     required String newTitle,
  ///   });
  /// }
  /// ```
  String get getCode {
    if (_fields.isEmpty) {
      return '';
    } else {
      return '''
// ignore: one_member_abstracts
abstract class _\$DriverProvidedProperties {

  /// This function allows you to react to changes of the `driverProvidableProperties` in the driver. 
  ///
  /// These properties are coming to the driver from the widget, and in Flutter, the widgets get recreated often. 
  /// But the driver does not get recreated for each widget creation. The drivers lifecycle is similar to that of a state.
  /// That means that your driver constructor is not called when a new widget is created.
  /// So the driver constructor does not get a chance to read any potential changes of the properties in the widget.
  ///
  /// Important, you do not need to call `notifyWidget()` in this method. 
  /// This method is called right before the build method of the DrivableWidget. 
  /// Thus all data changed here will be shown with the "currently ongoing render cycle".
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
