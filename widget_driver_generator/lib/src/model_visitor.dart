import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:source_gen/source_gen.dart';
import 'package:widget_driver_annotation/widget_driver_annotation.dart';

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
  AnnotationVisitor(this.classBuffer);

  final StringBuffer classBuffer;

  @override
  void visitFieldElement(FieldElement element) {
    if (_hasValidAnnotation(element, DriverProperty)) {
      final value = _getValueForElement(element, "DriverProperty");
      classBuffer.writeln('\n');
      classBuffer.writeln('@override');
      classBuffer.writeln('${element.toString()} = $value;');
    }
  }

  @override
  void visitPropertyAccessorElement(PropertyAccessorElement element) {
    if (_hasValidAnnotation(element, DriverProperty)) {
      final value = _getValueForElement(element, "DriverProperty");
      classBuffer.writeln('\n');
      classBuffer.writeln('@override');
      classBuffer.writeln('${element.toString()} => $value;');
    }
  }

  @override
  void visitMethodElement(MethodElement element) {
    if (_hasValidAnnotation(element, DriverAction)) {
      final value = _getValueForElement(element, "DriverAction");
      classBuffer.writeln('\n');
      classBuffer.writeln('@override');
      if (value.isNotEmpty) {
        classBuffer.writeln('${element.toString()} {');
        classBuffer.writeln('return $value;');
        classBuffer.writeln('}');
      } else {
        classBuffer.writeln('${element.toString()} {}');
      }
    }
  }

  bool _hasValidAnnotation(Element element, Type type) {
    final annotation =
        TypeChecker.fromRuntime(type).firstAnnotationOfExact(element);
    return annotation != null;
  }

  String _getValueForElement(Element element, String typeName) {
    final metaData = element.metadata.first;
    final source = metaData.toSource();
    return source.substring("@$typeName(".length, source.length - 1);
  }
}
