import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver_generator/src/code_providers/test_driver_code_provider.dart';
import 'package:widget_driver_generator/src/models/annotated_element.dart';

void main() {
  group('TestDriverCodeProvider:', () {
    test('Builds with no elements', () {
      final codeProvider = TestDriverCodeProvider(
        methods: [],
        properties: [],
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class TestExampleProvider extends ExampleDriver {

}
''';
      expect(codeProvider.code, expected);
    });
    test('Builds with one field', () {
      final codeProvider = TestDriverCodeProvider(
        methods: [],
        properties: [],
        fields: [
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'final String example'),
        ],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class TestExampleProvider extends ExampleDriver {
@override
final String example = '\'\'';

}
''';
      expect(codeProvider.code, expected);
    });
    test('Builds with multiple fields', () {
      final codeProvider = TestDriverCodeProvider(
        methods: [],
        properties: [],
        fields: [
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'final String example'),
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'final String example2'),
        ],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class TestExampleProvider extends ExampleDriver {
@override
final String example = '\'\'';

@override
final String example2 = '\'\'';

}
''';
      expect(codeProvider.code, expected);
    });
    test("Builds with one property", () {
      final codeProvider = TestDriverCodeProvider(
        methods: [
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String get example'),
        ],
        properties: [],
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class TestExampleProvider extends ExampleDriver {
@override
String get example => '\'\'';

}
''';
      expect(codeProvider.code, expected);
    });
    test("Builds with multiple properties", () {
      final codeProvider = TestDriverCodeProvider(
        methods: [],
        properties: [
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String get example'),
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String get example2'),
        ],
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class TestExampleProvider extends ExampleDriver {
@override
String get example => '\'\'';

@override
String get example2 => '\'\'';

}
''';
      expect(codeProvider.code, expected);
    });
    test('Builds with one method', () {
      final codeProvider = TestDriverCodeProvider(
        methods: [
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String example()'),
        ],
        properties: [],
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class TestExampleProvider extends ExampleDriver {
@override
String example() {
  return ''
}

}
''';
      expect(codeProvider.code, expected);
    });
    test('Builds with multiple methods', () {
      final codeProvider = TestDriverCodeProvider(
        methods: [
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String example()'),
          AnnotatedElement(returnValue: '', codeDefinition: 'void example2()'),
        ],
        properties: [],
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class TestExampleProvider extends ExampleDriver {
@override
String example() {
  return ''
}

@override
void example2() {}

}
''';
      expect(codeProvider.code, expected);
    });

    test('Builds mixed', () {
      final codeProvider = TestDriverCodeProvider(
        methods: [
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String example()'),
          AnnotatedElement(returnValue: '', codeDefinition: 'void example2()'),
        ],
        properties: [
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String get example'),
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String get example2'),
        ],
        fields: [
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'final String example'),
          AnnotatedElement(returnValue: '\'\'', codeDefinition: 'final String example2'),
        ],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class TestExampleProvider extends ExampleDriver {
  @override
final String example = '\'\'';

@override
final String example2 = '\'\'';

@override
String get example => '\'\'';

@override
String get example2 => '\'\'';

@override
String example() {
  return ''
}

@override
void example2() {}

}
''';
      expect(codeProvider.code, expected);
    });
  });
}
