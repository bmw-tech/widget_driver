import 'package:build/build.dart';
import 'package:mocktail/mocktail.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'package:analyzer/dart/element/element.dart';

import 'package:widget_driver_generator/src/widget_driver_generator.dart';

class MockConstantReader extends Mock implements ConstantReader {}

// ignore: SUBTYPE_OF_SEALED_CLASS
class MockBuildStep extends Mock implements BuildStep {}

class MockElement extends Mock implements Element {}

void main() {
  late MockConstantReader mockConstantReader;
  late MockBuildStep mockBuildStep;
  late MockElement mockElement;

  setUp(() {
    mockConstantReader = MockConstantReader();
    mockBuildStep = MockBuildStep();
    mockElement = MockElement();
  });

  group('WidgetDriverGenerator:', () {
    test('Generated code contains code-coverage-ignore', () async {
      final widgetDriverGenerator = WidgetDriverGenerator();
      final generatedCode = await widgetDriverGenerator.generateForAnnotatedElement(
        mockElement,
        mockConstantReader,
        mockBuildStep,
      );
      const expectedString = '// coverage:ignore-file';
      expect(generatedCode.contains(expectedString), isTrue);
    });

    test('Generated code contains package version', () async {
      final widgetDriverGenerator = WidgetDriverGenerator();
      final generatedCode = await widgetDriverGenerator.generateForAnnotatedElement(
        mockElement,
        mockConstantReader,
        mockBuildStep,
      );
      const expectedString = '// This file was generated with widget_driver_generator ';
      expect(generatedCode.contains(expectedString), isTrue);
    });
  });
}
