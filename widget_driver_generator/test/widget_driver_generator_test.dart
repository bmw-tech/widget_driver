import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:mocktail/mocktail.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'package:widget_driver_generator/src/utils/default_return_value_helper.dart';
import 'package:widget_driver_generator/src/utils/package_info_provider.dart';
import 'package:widget_driver_generator/src/widget_driver_generator.dart';
import 'package:yaml/yaml.dart';

class MockConstantReader extends Mock implements ConstantReader {}

class MockPackageInfoProvider extends Mock implements PackageInfoProvider {}

// ignore: SUBTYPE_OF_SEALED_CLASS
class MockBuildStep extends Mock implements BuildStep {}

class MockElement extends Mock implements Element {}

class MockBuilderOptions extends Mock implements BuilderOptions {}

class ImaginaryClass implements DartType {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Element get element => MockElement();

  @override
  String toString() {
    return "ImaginaryClass";
  }
}

void main() {
  late MockConstantReader mockConstantReader;
  late MockBuildStep mockBuildStep;
  late MockElement mockElement;
  late MockPackageInfoProvider mockPackageInfoProvider;
  late MockBuilderOptions mockBuilderOptions;

  setUpAll(() {
    mockConstantReader = MockConstantReader();
    mockBuildStep = MockBuildStep();
    mockElement = MockElement();
    mockPackageInfoProvider = MockPackageInfoProvider();
    mockBuilderOptions = MockBuilderOptions();

    when(() => mockBuilderOptions.config).thenReturn({});
  });

  group('WidgetDriverGenerator:', () {
    test("Sets defaultReturnValues if some where passed in the constructor", () {
      expect(DefaultReturnValueHelper.hasDefaultValueForType(ImaginaryClass()), isFalse);
      var fakeMap = YamlMap.wrap({ImaginaryClass: 'ImaginaryClass()'});
      when(() => mockBuilderOptions.config).thenReturn({"defaultTestValues": fakeMap});
      WidgetDriverGenerator(options: mockBuilderOptions);
      expect(DefaultReturnValueHelper.hasDefaultValueForType(ImaginaryClass()), isTrue);
      expect(DefaultReturnValueHelper.getDefaultValueFor(ImaginaryClass()), "ImaginaryClass()");
    });

    test('Generated code contains code-coverage-ignore', () async {
      final widgetDriverGenerator = WidgetDriverGenerator(options: mockBuilderOptions);
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

      final widgetDriverGenerator = WidgetDriverGenerator(
        options: mockBuilderOptions,
        packageInfoProvider: mockPackageInfoProvider,
      );
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
