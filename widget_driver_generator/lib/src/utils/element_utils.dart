import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widget_driver_annotation/widget_driver_annotation.dart';

import 'type_utils.dart';

/// A helper class for getting data out of elements
class ElementUtils {
  /// Checks if the current element has an annotation which is valid.
  /// If it has a valid annotation, then that annotation type is returned, else it returns null.
  Type? getValidAnnotation({
    required Element element,
    required List<Type> validAnnotationTypes,
  }) {
    for (var validAnnotationType in validAnnotationTypes) {
      final annotation = TypeChecker.fromRuntime(validAnnotationType).firstAnnotationOfExact(element);
      if (annotation != null) {
        return validAnnotationType;
      }
    }
    return null;
  }

  /// Checks if the current `element` has an annotation of the provided `validAnnotationType`.
  /// Returns `true`, if this true and `false` accordingly.
  bool hasValidAnnotation({
    required Element element,
    required Type validAnnotationType,
  }) =>
      getValidAnnotation(element: element, validAnnotationTypes: [validAnnotationType]) != null;

  /// Get the string definition of the current element.
  /// E.g. if the element is a `PropertyAccessorElement` which returns a bool and
  /// the property is called `getMyBool` then this function would return something like this:
  /// `bool get getMyBool`
  /// This is defined as the definition for that element.
  /// For a method you would get back this:
  /// `void myFunction(int someValue)`
  String getCodeDefinitionForElement(Element element) {
    return element.toString();
  }

  /// Gets the return value for the given element.
  /// The return value is contained inside the annotationType.
  /// This function find the correct annotation of the element and grab the return
  /// value and return it. If the annotation is a `TestDriverDefaultFutureValue`
  /// then the return value will be wrapped inside a `Future.value({THE_ORIGINAL_RETURN_VALUE})`.
  String getReturnValue({required Element element, required Type annotationType}) {
    final annotationString = _getAnnotationStringFromElement(element);
    final annotationValue = _getAnnotationWithoutTypeName(annotationString, annotationType);
    return annotationValue;
  }

  String _getAnnotationStringFromElement(Element element) {
    final metaData = element.metadata.first;
    return metaData.toSource();
  }

  String _getAnnotationWithoutTypeName(String annotationString, Type annotationType) {
    final typeName = TypeUtils.getTypeName(annotationType);
    String annotationValue = annotationString.substring('@$typeName('.length, annotationString.length - 1);
    if (annotationType == TestDriverDefaultFutureValue) {
      annotationValue = 'Future.value($annotationValue)';
    }
    return annotationValue;
  }
}
