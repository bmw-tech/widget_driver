import 'package:flutter_test/flutter_test.dart';
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
    test('DriverProviderCodeProvider returns code without fields', () {
      final codeProvider = DriverProviderCodeProvider(
        fields: [
          ProvidableField(
            name: 'example',
            type: ''.runtimeType.toString(),
            isRequired: true,
            isNamed: false,
          )
        ],
        driverClassName: 'ExampleDriver',
      );
      const expectedCode = '''
class \$ExampleDriverProvider extends WidgetDriverProvider<ExampleDriver> {
  final String _example;

  \$ExampleDriverProvider({
    required String example;
  }) : _example = example;

  @override
  ExampleDriver buildDriver(BuildContext context) {
    return ExampleDriver(context , example: _example,);
  }

  @override
  ExampleDriver buildTestDriver() {
    return _\$TestExampleDriver();
  }
}
''';
      expect(codeProvider.driverProviderClass, expectedCode);
    });
  });
}
