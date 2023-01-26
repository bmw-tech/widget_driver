import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widget_driver_annotation/widget_driver_annotation.dart';
import 'package:widget_driver_generator/src/utils/code_writer.dart';
import 'package:widget_driver_generator/src/utils/providable_variable_code_generator.dart';

import 'model_visitor.dart';

/// Generates TestDrivers and WidgetDriverProviders based on annotations
class WidgetDriverGenerator extends GeneratorForAnnotation<GenerateTestDriver> {
  @override
  Future<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final codeWriter = CodeWriter();
    final driverClassName = visitor.className;
    final providerClassName = '\$${driverClassName}Provider';

    //###################################
    // Start - Package version generation
    //###################################

    final packageVersionString = await _getPackageVersionString();
    codeWriter.writeCode('// This file was generated with widget_driver_generator $packageVersionString\n');

    //###################################
    // Start - TestDriver generation
    //###################################

    final testDriverClassName = '_\$Test$driverClassName';

    codeWriter.writeCode('class $testDriverClassName extends TestDriver implements $driverClassName {');
    final annotationVisitor = AnnotationVisitor(codeWriter: codeWriter);
    element.visitChildren(annotationVisitor);
    codeWriter.writeCode('}');

    //###################################
    // Start - DriverProvider generation
    //###################################

    codeWriter.writeCode('class $providerClassName extends WidgetDriverProvider<$driverClassName> {');

    final providablesGenerator = ProvidableVariableCodeGenerator(
      codeWriter: codeWriter,
      fields: visitor.providableFields,
      providerClassName: providerClassName,
    );

    providablesGenerator.generateFields();

    providablesGenerator.generateConstructor();
    codeWriter.writeCode('@override');
    codeWriter.writeCode('$driverClassName buildDriver(BuildContext context) {');
    codeWriter.writeCode('return $driverClassName(context ${providablesGenerator.generateParameters()});');
    codeWriter.writeCode('}');

    codeWriter.writeCode('@override');
    codeWriter.writeCode('$driverClassName buildTestDriver() {');
    codeWriter.writeCode('return $testDriverClassName();');
    codeWriter.writeCode('}');

    codeWriter.writeCode('}');

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
