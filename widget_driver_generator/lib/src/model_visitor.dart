import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:widget_driver_annotation/widget_driver_annotation.dart';
import 'package:widget_driver_generator/src/utils/providable_field.dart';

import 'utils/code_writer.dart';
import 'utils/source_code_generator.dart';
import 'utils/element_utils.dart';

typedef CodeGeneratorMethod = String Function(String codeDefinition, String returnValue);

/// Inspect classes and get className, fields and all constructor parameters annotated with the @driverProvidableFields.
class ModelVisitor extends SimpleElementVisitor<void> {
  String className = "";
  final fields = <String, dynamic>{};
  final providableFields = <ProvidableField>[];
  final ElementUtils _elementUtils;

  ModelVisitor({ElementUtils? elementUtils})
      : _elementUtils = elementUtils ?? ElementUtils(),
        super();

  @override
  void visitConstructorElement(ConstructorElement element) {
    final elementReturnType = element.type.returnType.toString();
    className = elementReturnType.replaceFirst('*', '');

    if (!element.isFactory || !element.isDefaultConstructor) {
      for (final param in element.parameters) {
        if (_elementUtils.hasValidAnnotation(
          element: param,
          validAnnotationType: driverProvidableModel.runtimeType,
        )) {
          providableFields.add(
            ProvidableField(
              name: param.name,
              type: param.type.toString().replaceFirst('*', ''),
              isRequired: param.isRequired,
              defaultValueCode: param.defaultValueCode,
              isNamed: param.isNamed,
            ),
          );
        }
      }
    }
  }

  @override
  void visitFieldElement(FieldElement element) {
    final elementType = element.type.toString();
    fields[element.name] = elementType.replaceFirst('*', '');
  }
}

/// Inspect Driver-related annotations and generate TestDriver with overrides based on default values
class AnnotationVisitor extends SimpleElementVisitor<void> {
  final CodeWriter codeWriter;
  final ElementUtils elementUtils;
  final List<Type> _validAnnotationTypes = [
    TestDriverDefaultValue,
    TestDriverDefaultFutureValue,
  ];

  AnnotationVisitor({required this.codeWriter, ElementUtils? elementUtils})
      : elementUtils = elementUtils ?? ElementUtils(),
        super();

  @override
  void visitFieldElement(FieldElement element) {
    CodeGeneratorMethod storedPropertyGenerator = ((propertyDefinition, returnValue) {
      return SourceCodeGenerator.getStoredPropertyCode(propertyDefinition, returnValue);
    });
    _generateAndWriteCode(element, storedPropertyGenerator);
  }

  @override
  void visitPropertyAccessorElement(PropertyAccessorElement element) {
    CodeGeneratorMethod computedPropertyGenerator = ((propertyDefinition, returnValue) {
      return SourceCodeGenerator.getComputedPropertyCode(propertyDefinition, returnValue);
    });
    _generateAndWriteCode(element, computedPropertyGenerator);
  }

  @override
  void visitMethodElement(MethodElement element) {
    CodeGeneratorMethod methodGenerator = ((methodDefinition, returnValue) {
      return SourceCodeGenerator.getMethodCode(methodDefinition, returnValue);
    });
    _generateAndWriteCode(element, methodGenerator);
  }

  void _generateAndWriteCode(Element element, CodeGeneratorMethod codeGenerator) {
    final validAnnotationType = elementUtils.getValidAnnotation(
      element: element,
      validAnnotationTypes: _validAnnotationTypes,
    );
    if (validAnnotationType != null) {
      final returnValue = elementUtils.getReturnValue(element: element, annotationType: validAnnotationType);
      final codeDefinition = elementUtils.getCodeDefinitionForElement(element);
      codeWriter.writeCode(SourceCodeGenerator.getEmptyLineCode());
      codeWriter.writeCode(codeGenerator(codeDefinition, returnValue));
    }
  }
}
