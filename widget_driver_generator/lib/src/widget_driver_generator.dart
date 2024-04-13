import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widget_driver_annotation/widget_driver_annotation.dart';
import 'package:widget_driver_generator/src/code_providers/driver_provider_code_provider.dart';
import 'package:widget_driver_generator/src/code_providers/provided_properties_interface_code_provider.dart';
import 'package:widget_driver_generator/src/code_providers/test_driver_code_provider.dart';
import 'package:widget_driver_generator/src/utils/code_writer.dart';
import 'package:yaml/yaml.dart';

import 'model_visitor.dart';
import 'utils/default_return_value_helper.dart';
import 'utils/package_info_provider.dart';

/// Generates TestDrivers and WidgetDriverProviders based on annotations
class WidgetDriverGenerator extends GeneratorForAnnotation<GenerateTestDriver> {
  final PackageInfoProvider _packageInfoProvider;

  WidgetDriverGenerator({
    required BuilderOptions options,
    PackageInfoProvider? packageInfoProvider,
  }) : _packageInfoProvider = packageInfoProvider ?? PackageInfoProvider() {
    final config = (options.config["defaultTestValues"] as YamlMap).entries;
    DefaultReturnValueHelper.setCustomDefaultValues(config);
  }



  @override
  Future<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    // Visit the annotated class and gather the data we need.
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final codeWriter = CodeWriter();
    final driverClassName = visitor.className;

    //#####################################################
    // Start - Package version generation and code coverage
    //#####################################################

    codeWriter.writeCode('// coverage:ignore-file\n');

    final packageVersionString = await _packageInfoProvider.getPackageVersionString();
    codeWriter.writeCode('// This file was generated with widget_driver_generator version $packageVersionString\n');

    //###################################
    // Start - TestDriver generation
    //###################################

    final testDriverCodeProvider = TestDriverCodeProvider(
      methods: visitor.methods,
      getProperties: visitor.getProperties,
      setProperties: visitor.setProperties,
      fields: visitor.fields,
      driverClassName: driverClassName,
    );

    codeWriter.writeCode(testDriverCodeProvider.code);

    //###################################
    // Start - DriverProvider generation
    //###################################

    final driverProviderCodeProvider = DriverProviderCodeProvider(
      fields: visitor.providableFields,
      driverClassName: driverClassName,
    );

    codeWriter.writeCode(driverProviderCodeProvider.driverProviderClass);

    //################################################
    // Start - ProvidedProperties Interface generation
    //################################################

    final providedPropertiesInterfaceCodeProvider = ProvidedPropertiesInterfaceCodeProvider(
      fields: visitor.providableFields,
    );

    codeWriter.writeCode(providedPropertiesInterfaceCodeProvider.getCode);

    return codeWriter.getAllCode();
  }
}
