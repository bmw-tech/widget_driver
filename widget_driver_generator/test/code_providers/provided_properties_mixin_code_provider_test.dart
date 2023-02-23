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
mixin \$SomeDriverProvidedPropertiesMixin {
  void updateProvidedProperties({required String newExample1,required String newExample2,required int newExample3,});
}
''');
    });
  });
}
