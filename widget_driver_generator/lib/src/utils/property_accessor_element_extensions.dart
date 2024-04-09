import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/dart/element/element.dart';

extension PropertyAccessorElementExtension on PropertyAccessorElement {
  /// All fields have implicit getters and setters.
  bool get isRedundantToFieldElement =>
      this is PropertyAccessorElementImpl_ImplicitSetter || this is PropertyAccessorElementImpl_ImplicitGetter;

  /// VoidType PropertyAccessorElements are setters.
  bool get isSetter => returnType is VoidType;
}
