import 'package:test/test.dart';

import 'package:widget_driver_generator/src/code_providers/driver_provider_code_provider.dart';
import 'package:widget_driver_generator/src/models/providable_field.dart';

void main() {
  group('DriverProviderCodeProviderTest', () {
    test('DriverProviderCodeProvider returns code without fields', () {
      final codeProvider = DriverProviderCodeProvider(
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expectedCode = '''
class \$ExampleDriverProvider extends WidgetDriverProvider<ExampleDriver> {
  @override
  ExampleDriver buildDriver(BuildContext context) {
    return ExampleDriver(context);
  }

  @override
  ExampleDriver buildTestDriver() {
    return _\$TestExampleDriver();
  }
}
''';
      expect(codeProvider.driverProviderClass, expectedCode);
    });

    test('DriverProviderCodeProvider returns code with fields', () {
      final codeProvider = DriverProviderCodeProvider(
        fields: [
          ProvidableField(
            name: 'example',
            type: ''.runtimeType.toString(),
            isRequired: true,
            isNamed: false,
          ),
          ProvidableField(
            name: 'example2',
            type: ''.runtimeType.toString(),
            isRequired: true,
            isNamed: true,
          ),
        ],
        driverClassName: 'ExampleDriver',
      );
      const expectedCode = '''
class \$ExampleDriverProvider extends WidgetDriverProvider<ExampleDriver> {
  final String _example;
final String _example2;

  \$ExampleDriverProvider({
    required String example,
required String example2,

  }) : _example = example,_example2 = example2;

  @override
  ExampleDriver buildDriver(BuildContext context) {
    return ExampleDriver(context , _example, example2: _example2,);
  }

  @override
  ExampleDriver buildTestDriver() {
    return _\$TestExampleDriver();
  }

  @override
  void updateDriverProvidedProperties(ExampleDriver driver) {

    // In case you get a compiler error here, you have to implement _\$DriverProvidedProperties in your driver.
    // Like this:
    //  class ExampleDriver extends WidgetDriver implements _\$DriverProvidedProperties {
    //    
    //    ...
    //
    //    @override
    //    void didUpdateProvidedProperties(...) {
    //      // Handle your updates
    //    }
    //  }
    driver.didUpdateProvidedProperties(newExample: _example,newExample2: _example2,);
  }
}
''';
      expect(codeProvider.driverProviderClass, expectedCode);
    });
  });
}
