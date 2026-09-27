import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

extension PropertyAccessorElementExtension on PropertyAccessorElement {
  /// All fields have implicit getters and setters.
  bool get isRedundantToFieldElement => isSynthetic;

  /// VoidType PropertyAccessorElements are setters.
  bool get isSetter => returnType is VoidType;
}
