import 'package:test/test.dart';
import 'package:widget_driver_generator/src/code_providers/test_driver_code_provider.dart';
import 'package:widget_driver_generator/src/models/annotated_element.dart';

void main() {
  group('TestDriverCodeProvider:', () {
    test('Builds with no elements', () {
      final codeProvider = TestDriverCodeProvider(
        methods: [],
        getProperties: [],
        setProperties: [],
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class _\$TestExampleDriver extends TestDriver implements ExampleDriver {
  

  

  
}
''';
      expect(codeProvider.code, expected);
    });

    test('Builds with one field', () {
      final codeProvider = TestDriverCodeProvider(
        methods: [],
        getProperties: [],
        setProperties: [],
        fields: [
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'final String example'),
        ],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class _\$TestExampleDriver extends TestDriver implements ExampleDriver {
  @override
final String example = '';

  

  
}
''';
      expect(codeProvider.code, expected);
    });

    test('Builds with multiple fields', () {
      final codeProvider = TestDriverCodeProvider(
        methods: [],
        getProperties: [],
        setProperties: [],
        fields: [
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'final String example'),
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'final String example2'),
        ],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class _\$TestExampleDriver extends TestDriver implements ExampleDriver {
  @override
final String example = '';

@override
final String example2 = '';

  

  
}
''';
      expect(codeProvider.code, expected);
    });

    test("Builds with one getProperty", () {
      final codeProvider = TestDriverCodeProvider(
        methods: [],
        getProperties: [
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String get example'),
        ],
        setProperties: [],
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class _\$TestExampleDriver extends TestDriver implements ExampleDriver {
  

  @override
String get example => '';

  
}
''';
      expect(codeProvider.code, expected);
    });

    test("Builds with multiple getProperties", () {
      final codeProvider = TestDriverCodeProvider(
        methods: [],
        getProperties: [
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String get example'),
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String get example2'),
        ],
        setProperties: [],
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class _\$TestExampleDriver extends TestDriver implements ExampleDriver {
  

  @override
String get example => '';

@override
String get example2 => '';

  
}
''';
      expect(codeProvider.code, expected);
    });

    test("Builds with one setProperty", () {
      final codeProvider = TestDriverCodeProvider(
        methods: [],
        getProperties: [],
        setProperties: [
          const AnnotatedElement(returnValue: '', codeDefinition: 'void set example(String newExample)'),
        ],
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class _\$TestExampleDriver extends TestDriver implements ExampleDriver {
  

  @override
set example(String newExample) {}

  
}
''';
      expect(codeProvider.code, expected);
    });

    test("Builds with multiple setProperties", () {
      final codeProvider = TestDriverCodeProvider(
        methods: [],
        getProperties: [],
        setProperties: [
          const AnnotatedElement(returnValue: '', codeDefinition: 'void set example(String newExample)'),
          const AnnotatedElement(returnValue: '', codeDefinition: 'void set example2(String newExample2)'),
        ],
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class _\$TestExampleDriver extends TestDriver implements ExampleDriver {
  

  @override
set example(String newExample) {}

@override
set example2(String newExample2) {}

  
}
''';
      expect(codeProvider.code, expected);
    });

    test('Builds with one method', () {
      final codeProvider = TestDriverCodeProvider(
        methods: [
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String example()'),
        ],
        getProperties: [],
        setProperties: [],
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class _\$TestExampleDriver extends TestDriver implements ExampleDriver {
  

  

  @override
String example() {
  return '';
}
}
''';
      expect(codeProvider.code, expected);
    });

    test('Builds with multiple methods', () {
      final codeProvider = TestDriverCodeProvider(
        methods: [
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String example()'),
          const AnnotatedElement(returnValue: '', codeDefinition: 'void example2()'),
        ],
        getProperties: [],
        setProperties: [],
        fields: [],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class _\$TestExampleDriver extends TestDriver implements ExampleDriver {
  

  

  @override
String example() {
  return '';
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
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String example()'),
          const AnnotatedElement(returnValue: '', codeDefinition: 'void example2()'),
        ],
        getProperties: [
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String get example'),
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'String get example2'),
        ],
        setProperties: [
          const AnnotatedElement(returnValue: '', codeDefinition: 'void set example(String newExample)'),
          const AnnotatedElement(returnValue: '', codeDefinition: 'void set example2(String newExample2)'),
        ],
        fields: [
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'final String example'),
          const AnnotatedElement(returnValue: '\'\'', codeDefinition: 'final String example2'),
        ],
        driverClassName: 'ExampleDriver',
      );
      const expected = '''
class _\$TestExampleDriver extends TestDriver implements ExampleDriver {
  @override
final String example = '';

@override
final String example2 = '';

  @override
String get example => '';

@override
String get example2 => '';

@override
set example(String newExample) {}

@override
set example2(String newExample2) {}

  @override
String example() {
  return '';
}

@override
void example2() {}
}
''';
      expect(codeProvider.code, expected);
    });
  });
}
