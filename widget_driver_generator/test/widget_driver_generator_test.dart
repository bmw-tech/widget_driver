import 'package:build/build.dart';
import 'package:mocktail/mocktail.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:widget_driver_generator/src/utils/package_info_provider.dart';

import 'package:widget_driver_generator/src/widget_driver_generator.dart';

class MockConstantReader extends Mock implements ConstantReader {}

class MockPackageInfoProvider extends Mock implements PackageInfoProvider {}

// ignore: SUBTYPE_OF_SEALED_CLASS
class MockBuildStep extends Mock implements BuildStep {}

class MockElement extends Mock implements Element {}

void main() {
  late MockConstantReader mockConstantReader;
  late MockBuildStep mockBuildStep;
  late MockElement mockElement;
  late MockPackageInfoProvider mockPackageInfoProvider;

  setUp(() {
    mockConstantReader = MockConstantReader();
    mockBuildStep = MockBuildStep();
    mockElement = MockElement();
    mockPackageInfoProvider = MockPackageInfoProvider();
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
      const expectedVersionNumber = '"1.2.3"';
      when(() => mockPackageInfoProvider.getPackageVersionString()).thenAnswer(
        (_) => Future.value(expectedVersionNumber),
      );

      final widgetDriverGenerator = WidgetDriverGenerator(packageInfoProvider: mockPackageInfoProvider);
      final generatedCode = await widgetDriverGenerator.generateForAnnotatedElement(
        mockElement,
        mockConstantReader,
        mockBuildStep,
      );
      const expectedString = '// This file was generated with widget_driver_generator version "1.2.3"';
      expect(generatedCode.contains(expectedString), isTrue);
    });
  });
}
