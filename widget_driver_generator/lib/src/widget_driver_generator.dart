import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widget_driver_annotation/widget_driver_annotation.dart';
import 'package:widget_driver_generator/src/code_providers/driver_provider_code_provider.dart';
import 'package:widget_driver_generator/src/code_providers/provided_properties_mixin_code_provider.dart';
import 'package:widget_driver_generator/src/code_providers/test_driver_code_provider.dart';
import 'package:widget_driver_generator/src/utils/code_writer.dart';

import 'model_visitor.dart';

/// Generates TestDrivers and WidgetDriverProviders based on annotations
class WidgetDriverGenerator extends GeneratorForAnnotation<GenerateTestDriver> {
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

    final packageVersionString = await _getPackageVersionString();
    codeWriter.writeCode('// This file was generated with widget_driver_generator $packageVersionString\n');

    //###################################
    // Start - TestDriver generation
    //###################################

    final testDriverCodeProvider = TestDriverCodeProvider(
      methods: visitor.methods,
      properties: visitor.properties,
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

    final providedPropertiesMixinCodeProvider = ProvidedPropertiesMixinCodeProvider(
      fields: visitor.providableFields,
      driverClassName: driverClassName,
    );

    codeWriter.writeCode(providedPropertiesMixinCodeProvider.providedPropertiesMixinClass);

    return codeWriter.getAllCode();
  }

  /// Grabs the version string from the pubspec.yaml
  Future<String> _getPackageVersionString() async {
    final file = File('pubspec.yaml');
    final pubspecString = await file.readAsString();
    final exp = RegExp(r'version: .+');
    final match = exp.firstMatch(pubspecString)!;
    return match[0]!;
  }
}
