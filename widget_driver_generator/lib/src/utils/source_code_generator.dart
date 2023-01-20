/// This class can generate string based code.
class SourceCodeGenerator {
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
  static String getStoredPropertyCode(String propertyDefinition, String returnValue) {
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
  static String getComputedPropertyCode(String propertyDefinition, String returnValue) {
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
  static String getMethodCode(String methodDefinition, String returnValue) {
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

  static String getEmptyLineCode() {
    return '\n';
  }
}
