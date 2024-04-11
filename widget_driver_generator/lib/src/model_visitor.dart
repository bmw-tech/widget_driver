import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:widget_driver_annotation/widget_driver_annotation.dart';

import 'models/annotated_element.dart';
import 'models/providable_field.dart';
import 'utils/element_utils.dart';
import 'utils/field_element_extensions.dart';
import 'utils/property_accessor_element_extensions.dart';

typedef CodeGeneratorMethod = String Function(String codeDefinition, String returnValue);

/// Inspect classes and get className, fields and all constructor parameters annotated with the @driverProvidableFields.
class ModelVisitor extends SimpleElementVisitor<void> {
  String className = "";
  final fields = <AnnotatedElement>[];
  final methods = <AnnotatedElement>[];
  final getProperties = <AnnotatedElement>[];
  final setProperties = <AnnotatedElement>[];
  final providableFields = <ProvidableField>[];
  final ElementUtils _elementUtils;

  final List<Type> _validAnnotationTypes = const [
    TestDriverDefaultValue,
    TestDriverDefaultFutureValue,
  ];

  ModelVisitor({ElementUtils? elementUtils})
      : _elementUtils = elementUtils ?? const ElementUtils(),
        super();

  @override
  void visitConstructorElement(ConstructorElement element) {
    final elementReturnType = element.type.returnType.toString();
    className = elementReturnType.replaceFirst('*', '');

    if (!element.isFactory || !element.isDefaultConstructor) {
      for (final param in element.parameters) {
        if (_elementUtils.hasValidAnnotation(
          element: param,
          validAnnotationType: driverProvidableProperty.runtimeType,
        )) {
          providableFields.add(ProvidableField.fromParameterElement(param));
        }
      }
    }
  }

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isRedundantToPropertyAccessorElement) {
      return;
    }
    final validAnnotationType = _elementUtils.getValidAnnotation(
      element: element,
      validAnnotationTypes: _validAnnotationTypes,
    );
    if (element.isPublic) {
      final type = element.type;
      fields.add(AnnotatedElement.fromElement(_elementUtils, element, validAnnotationType, type));
    }
  }

  @override
  void visitPropertyAccessorElement(PropertyAccessorElement element) {
    if (element.isRedundantToFieldElement) {
      return;
    }
    final validAnnotationType = _elementUtils.getValidAnnotation(
      element: element,
      validAnnotationTypes: _validAnnotationTypes,
    );
    if (element.isPublic) {
      final returnType = element.returnType;
      final property = AnnotatedElement.fromElement(_elementUtils, element, validAnnotationType, returnType);
      if (element.isSetter) {
        setProperties.add(property);
      } else {
        getProperties.add(property);
      }
    }
  }

  @override
  void visitMethodElement(MethodElement element) {
    final validAnnotationType = _elementUtils.getValidAnnotation(
      element: element,
      validAnnotationTypes: _validAnnotationTypes,
    );
    if (element.isPublic) {
      final returnType = element.returnType;
      methods.add(AnnotatedElement.fromElement(_elementUtils, element, validAnnotationType, returnType));
    }
  }
}
