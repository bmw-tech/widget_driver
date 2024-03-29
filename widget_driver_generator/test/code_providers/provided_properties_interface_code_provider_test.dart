import 'package:test/test.dart';
import 'package:widget_driver_generator/src/code_providers/provided_properties_interface_code_provider.dart';
import 'package:widget_driver_generator/src/models/providable_field.dart';

void main() {
  group('ProvidedPropertiesInterfaceCodeProviderTest:', () {
    test('Returns nothing, if there are no providedFields', () {
      final fields = <ProvidableField>[];
      final codeProvider = ProvidedPropertiesInterfaceCodeProvider(
        fields: fields,
      );
      expect(codeProvider.getCode, '');
    });

    test('Returns correctly from providedFields', () {
      final fields = <ProvidableField>[
        const ProvidableField(
          name: 'example1',
          type: 'String',
          isRequired: true,
          isNamed: false,
        ),
        const ProvidableField(
          name: 'example2',
          type: 'String',
          isRequired: false,
          isNamed: true,
        ),
        const ProvidableField(name: 'example3', type: 'int', isRequired: false, isNamed: false),
      ];
      final codeProvider = ProvidedPropertiesInterfaceCodeProvider(
        fields: fields,
      );
      expect(codeProvider.getCode, '''
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
  /// it is NOT the place to run time consuming or blocking tasks etc. (like calling Api-Endpoints)
  /// This could greatly impact your apps performance.
  void didUpdateProvidedProperties({required String newExample1,required String newExample2,required int newExample3,});
}
''');
    });
  });
}
