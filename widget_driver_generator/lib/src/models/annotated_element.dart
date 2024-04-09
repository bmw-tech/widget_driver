import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:widget_driver_generator/src/utils/element_utils.dart';

import '../utils/default_return_value_helper.dart';

/// Class representing fields, properties and methods that have been annotated with either `TestDriverDefaultValue` or
/// `TestDriverDefaultFutureValue`, to keep track of the [returnValue] and [codeDefinition].
class AnnotatedElement {
  final String returnValue;
  final String codeDefinition;

  const AnnotatedElement({
    required this.returnValue,
    required this.codeDefinition,
  });

  factory AnnotatedElement.fromElement(
    ElementUtils elementUtils,
    Element element,
    dynamic validAnnotationType,
    DartType elementType,
  ) {
    final codeDefinition = elementUtils.getCodeDefinitionForElement(element);
    if (validAnnotationType == null && DefaultReturnValueHelper.hasDefaultValueForType(elementType)) {
      return AnnotatedElement(
        returnValue: DefaultReturnValueHelper.getDefaultValueFor(elementType),
        codeDefinition: codeDefinition,
      );
    } else if (validAnnotationType != null) {
      final returnValue = elementUtils.getReturnValue(element: element, annotationType: validAnnotationType);
      return AnnotatedElement(returnValue: returnValue, codeDefinition: codeDefinition);
    } else {
      throw Exception("""
${elementType.toString()} has no default test value. 
You need to annotate "$codeDefinition" with a default value:
...
  @TestDriverDefaultValue(Instance of ${elementType.toString()})
  $codeDefinition
...
      """);
    }
  }
}
