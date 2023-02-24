import 'package:test/test.dart';
import 'package:widget_driver_generator/src/code_providers/provided_properties_mixin_code_provider.dart';
import 'package:widget_driver_generator/src/models/providable_field.dart';

void main() {
  group('ProvidedPropertiesMixinCodeProviderTest:', () {
    test('Returns nothing, if there are no providedFields', () {
      final fields = <ProvidableField>[];
      final codeProvider = ProvidedPropertiesMixinCodeProvider(
        driverClassName: 'SomeDriver',
        fields: fields,
      );
      expect(codeProvider.providedPropertiesMixinClass, '');
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
      final codeProvider = ProvidedPropertiesMixinCodeProvider(
        driverClassName: 'SomeDriver',
        fields: fields,
      );
      expect(codeProvider.providedPropertiesMixinClass, '''
mixin _\$DriverProvidedPropertiesMixin {

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
  void updateDriverProvidedProperties({required String newExample1,required String newExample2,required int newExample3,});
}
''');
    });
  });
}
