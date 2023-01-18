import 'dart:mirrors';

/// This is a helper class which contains methods for
/// reading out annotations from classes and methods.
class AnnotationInfoGetter {
  static T? getClassAnnotation<T>(Type type) {
    return reflectClass(type).metadata.first.reflectee as T;
  }

  static T? getMethodAnnotation<T>(dynamic objectMethod) {
    var methodMirror = (reflect(objectMethod) as ClosureMirror).function;
    return methodMirror.metadata.first.reflectee as T;
  }
}
