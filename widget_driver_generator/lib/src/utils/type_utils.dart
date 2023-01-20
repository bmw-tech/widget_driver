/// Contains utils and helper methods for actions you want to perform on dart types.
class TypeUtils {
  /// Returns the string name of a type.
  /// Removes the '<dynamic>' from the resulting string.
  /// E.g. If type is `TestDriverDefaultValue` then out-of-the-box you get
  /// `TestDriverDefaultValue<dynamic>` if you just to a `toString()`.
  /// This method will drop the `<dynamic>` and just return `TestDriverDefaultValue`
  static String getTypeName(Type type) {
    String typeName = '$type';
    const dynamicValuePostfix = '<dynamic>';
    if (typeName.contains(dynamicValuePostfix)) {
      typeName = typeName.substring(0, typeName.length - dynamicValuePostfix.length);
    }
    return typeName;
  }
}
