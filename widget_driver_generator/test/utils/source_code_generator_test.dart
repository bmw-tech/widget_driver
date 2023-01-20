import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver_generator/src/utils/source_code_generator.dart';

void main() {
  group('SourceCodeGenerator:', () {
    test('Get stored property code returns correct source code', () {
      final sourceCode = SourceCodeGenerator.getStoredPropertyCode(
        'bool isFetching',
        'false',
      );

      const expectedSourceCode = '''
@override
bool isFetching = false;''';
      expect(sourceCode, expectedSourceCode);
    });

    test('Get computed property code returns correct source code', () {
      final sourceCode = SourceCodeGenerator.getComputedPropertyCode(
        'bool get isFetching',
        'false',
      );

      const expectedSourceCode = '''
@override
bool get isFetching => false;''';
      expect(sourceCode, expectedSourceCode);
    });

    test('Get method source code for method with void return', () {
      final sourceCode = SourceCodeGenerator.getMethodCode(
        'void doSomeAction(int index)',
        '',
      );

      const expectedSourceCode = '''
@override
void doSomeAction(int index) {}''';
      expect(sourceCode, expectedSourceCode);
    });

    test('Get method source code for method with bool return', () {
      final sourceCode = SourceCodeGenerator.getMethodCode(
        'bool getSomeStatus(int index)',
        'true',
      );

      const expectedSourceCode = '''
@override
bool getSomeStatus(int index) {
  return true;
}''';
      expect(sourceCode, expectedSourceCode);
    });

    test('Get empty line code returns a new line', () {
      final sourceCode = SourceCodeGenerator.getEmptyLineCode();
      const expectedSourceCode = '\n';
      expect(sourceCode, expectedSourceCode);
    });
  });
}
