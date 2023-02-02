import 'package:analyzer/dart/element/element.dart';
import 'package:widget_driver_generator/src/utils/element_utils.dart';

class AnnotatedElement {
  final String returnValue;
  final String codeDefinition;

  AnnotatedElement({
    required this.returnValue,
    required this.codeDefinition,
  });

  factory AnnotatedElement.fromElement(
    ElementUtils elementUtils,
    Element element,
    dynamic validAnnotationType,
  ) {
    final returnValue = elementUtils.getReturnValue(element: element, annotationType: validAnnotationType);
    final codeDefinition = elementUtils.getCodeDefinitionForElement(element);
    return AnnotatedElement(returnValue: returnValue, codeDefinition: codeDefinition);
  }
}
