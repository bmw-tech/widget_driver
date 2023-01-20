import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:widget_driver_annotation/widget_driver_annotation.dart';
import 'package:widget_driver_generator/src/utils/code_writer.dart';
import 'package:widget_driver_generator/src/utils/source_code_generator.dart';

import 'utils/element_utils.dart';

typedef CodeGeneratorMethod = String Function(String codeDefinition, String returnValue);

/// Inspect classes and get className and fields out of them
class ModelVisitor extends SimpleElementVisitor<void> {
  String className = "";
  final fields = <String, dynamic>{};

  @override
  void visitConstructorElement(ConstructorElement element) {
    final elementReturnType = element.type.returnType.toString();
    className = elementReturnType.replaceFirst('*', '');
  }

  @override
  void visitFieldElement(FieldElement element) {
    final elementType = element.type.toString();
    fields[element.name] = elementType.replaceFirst('*', '');
  }
}

/// Inspect Driver-related annotations and generate TestDriver with overrides based on default values
class AnnotationVisitor extends SimpleElementVisitor<void> {
  AnnotationVisitor({required this.codeWriter, ElementUtils? elementUtils})
      : elementUtils = elementUtils ?? ElementUtils(),
        super();

  final CodeWriter codeWriter;
  final ElementUtils elementUtils;

  final List<Type> _validAnnotationTypes = [TestDriverDefaultValue, TestDriverDefaultFutureValue];

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
