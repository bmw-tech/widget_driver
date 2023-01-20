import 'package:flutter_test/flutter_test.dart';
import 'package:widget_driver_generator/src/utils/code_writer.dart';

void main() {
  group('CodeWriter:', () {
    test('Initially the codeWriter returns empty code', () {
      final codeWriter = CodeWriter();
      expect(codeWriter.getAllCode(), '');
    });

    test('Can write code once and then get that code back', () {
      final codeWriter = CodeWriter();
      codeWriter.writeCode('bool myBool = true;');
      const expectedCode = '''
bool myBool = true;
''';
      expect(codeWriter.getAllCode(), expectedCode);
    });

    test('Can write code twice and then get that code back in correct order', () {
      final codeWriter = CodeWriter();
      codeWriter.writeCode('bool myFirstBool = true;');
      codeWriter.writeCode('bool mySecondBool = false;');

      const expectedCode = '''
bool myFirstBool = true;
bool mySecondBool = false;
''';
      expect(codeWriter.getAllCode(), expectedCode);
    });

    test('Can write code once over multiple lines and get that code back', () {
      final codeWriter = CodeWriter();
      codeWriter.writeCode('bool myFirstBool = true;\nbool mySecondBool = false;');

      const expectedCode = '''
bool myFirstBool = true;
bool mySecondBool = false;
''';
      expect(codeWriter.getAllCode(), expectedCode);
    });
  });
}
