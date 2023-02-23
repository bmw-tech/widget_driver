import 'package:test/test.dart';
import 'package:widget_driver_generator/src/utils/string_extensions.dart';

void main() {
  group('StringExtensions:', () {
    group('removeLeadingUnderScore:', () {
      test('should return as is, if no String is empty', () {
        const testString = '';
        expect(testString.removeLeadingUnderscore(), testString);
      });
      test('should return as is, if first character is no underscore', () {
        const testString = 'hallo';
        expect(testString.removeLeadingUnderscore(), testString);
      });
      test('should remove leading underscore if it exists', () {
        const testString = '_hallo';
        expect(testString.removeLeadingUnderscore(), 'hallo');
      });
    });

    group('capitalizeFirstLetter:', () {
      test('Should return as is, if String is empty', () {
        const testString = '';
        expect(testString.capitalizeFirstLetter(), testString);
      });
      test('Should return correctly, if String is not empty', () {
        const testString = 'halloIchBinEinString';
        expect(testString.capitalizeFirstLetter(), 'HalloIchBinEinString');
      });
    });

    group('makeItNew:', () {
      test('should return as is, if String is empty', () {
        const testString = '';
        expect(testString.makeItNew(), testString);
      });
      test('should return correct string, if it is not empty', () {
        const testString = 'someValue';
        expect(testString.makeItNew(), 'newSomeValue');
      });
    });
  });
}
