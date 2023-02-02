import 'package:widget_driver_generator/src/utils/class_utils.dart';

import '../models/annotated_element.dart';

class TestDriverCodeProvider {
  final List<AnnotatedElement> _methods;
  final List<AnnotatedElement> _properties;
  final List<AnnotatedElement> _fields;
  final String _driverClassName;
  final String _testDriverClassName;

  TestDriverCodeProvider({
    required List<AnnotatedElement> methods,
    required List<AnnotatedElement> properties,
    required List<AnnotatedElement> fields,
    required String driverClassName,
  })  : _methods = methods,
        _properties = properties,
        _fields = fields,
        _driverClassName = driverClassName,
        _testDriverClassName = ClassUtils.testDriverClassName(driverClassName);

  /// Returns the code of the "TestDriver" class depending on the provided AnnotedElement lists.
  /// E.g.
  /// ```dart
  /// class _$TestExampleDriver extends TestDriver implements ExampleDriver {
  ///   @override
  ///   String get example1 => 'Example';
  ///
  ///   @override
  ///   void exampleMethod() {}
  /// }
  /// ```
  String get getCode => '''
class $_testDriverClassName extends TestDriver implements $_driverClassName {
  ${_fieldsCode()}

  ${_propertyCode()}

  ${_methodsCode()}
}
''';

  /// Joins `_getComputedPropertyCode()` for every property in `_properties`.
  String _propertyCode() =>
      _properties.map((e) => _getComputedPropertyCode(e.codeDefinition, e.returnValue)).join(doubleEmptyLine);

  /// Joins `_getMethodCode()` for every method in `_methods`.
  String _methodsCode() => _methods.map((e) => _getMethodCode(e.codeDefinition, e.returnValue)).join(doubleEmptyLine);

  /// Joins `_getStoredPropertyCode()` for every field in `_fields`.
  String _fieldsCode() =>
      _fields.map((e) => _getStoredPropertyCode(e.codeDefinition, e.returnValue)).join(doubleEmptyLine);

  /// Returns the code needed to implement an override of a stored property.
  /// A stored property is a property which is directly assigned.
  /// E.g.
  /// ```dart
  /// class MyClass {
  ///     bool myStoredProperty = false;
  /// }
  /// ```
  /// In this example, then the `bool myStoredProperty` would be
  /// the `propertyDefinition` and the `false` would be the returnValue.
  String _getStoredPropertyCode(String propertyDefinition, String returnValue) {
    String sourceCode = '''
@override
$propertyDefinition = $returnValue;''';
    return sourceCode;
  }

  /// Returns the code needed to implement an override of a computed property.
  /// A computed property is a property which is computed each time you want to access it.
  /// E.g.
  /// ```dart
  /// class MyClass {
  ///     bool get myComputedProperty => false;
  /// }
  /// ```
  /// In this example, then the `bool get myComputedProperty` would be
  /// the `propertyDefinition` and the `false` would be the returnValue.
  String _getComputedPropertyCode(String propertyDefinition, String returnValue) {
    String sourceCode = '''
@override
$propertyDefinition => $returnValue;''';
    return sourceCode;
  }

  /// Returns the code needed to implement an override of a method.
  /// If the method does not have a return value (meaning it is a void method)
  /// then this method simple return empty brackets.
  /// E.g.
  /// ```dart
  /// class MyClass {
  ///     void myMethod() {}
  ///
  ///     int getSomething(int someIndex) {
  ///         return 1;
  ///     }
  /// }
  /// ```
  /// In this example, then the `void myMethod()` and `int getSomething(int someIndex)` would be
  /// the `propertyDefinition` and the `1` would be the returnValue for the non-void function.
  String _getMethodCode(String methodDefinition, String returnValue) {
    String sourceCode;
    if (returnValue.isEmpty) {
      sourceCode = '''
@override
$methodDefinition {}''';
    } else {
      sourceCode = '''
@override
$methodDefinition {
  return $returnValue;
}''';
    }
    return sourceCode;
  }

  String get emptyLineCode => '\n';
  String get doubleEmptyLine => emptyLineCode + emptyLineCode;
}
