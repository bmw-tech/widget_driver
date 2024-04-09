import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

/// Class that provides logic to determine default return values.
class DefaultReturnValueHelper {
  /// Return the default value written as code inside a String for the passed in [type].
  /// It is important to call [hasDefaultValueForType] first to make sure a default value exists.
  /// Otherwise the code generation might generate faulty code.
  static String getDefaultValueFor(DartType type) {
    if (type.element is EnumElement) {
      // We can safely take the first enum value since dart enforces for enums to have at least one value.
      return "${_getSanitizedTypeName(type.toString())}.values[0]";
    }
    if (type is RecordType) {
      return _getDefaultValueForRecord(type);
    }
    if (type is InterfaceType && type.element is ClassElement && type.element.name == "Future") {
      final defaultValue = getDefaultValueFor(type.typeArguments.first);
      return "Future.value($defaultValue)";
    } else {
      return _getDefaultValueForTypeName(type.toString());
    }
  }

  /// Returns `true` if a default value exists for the passed in [type].
  /// If it returns `false`, [getDefaultValueFor] might not return a proper value and should not be used.
  static bool hasDefaultValueForType(DartType type) {
    if (type.element is EnumElement) {
      return true;
    }
    // RecordTypes are tuples (value1, value2) that were introduced with dart 3.0 and are a edge case here
    if (type is RecordType) {
      return _hasDefaultValueForRecord(type);
    }
    var typeName = type.toString();
    if (type is InterfaceType && type.element is ClassElement && type.element.name == "Future") {
      typeName = type.typeArguments.first.toString();
    }
    return _hasDefaultValueForTypeName(typeName);
  }

  // to introduce more types with default values, add them to this map.
  // All enum values and optional values are already covered and don't have to be put in here.
  static final Map<String, String> _defaultTypeValueMap = {
    "int": "0",
    "double": "0.0",
    "String": "''",
    "bool": "false",
    "List": "[]",
    "Set": "{}",
    "Map": "{}",
    "Symbol": "const Symbol(\"foo\")",
    "void": "",
    "Color": "Colors.black",
    "IconData": "const IconData(0)",
    "FontWeight": "FontWeight.normal",
  };

  static bool _hasDefaultValueForTypeName(String typeName) {
    // For all optionals we can return null as a value no matter if it's in the list or not.
    if (_isOptional(typeName)) {
      return true;
    }
    return _defaultTypeValueMap.containsKey(_getSanitizedTypeName(typeName));
  }

  static String _getDefaultValueForTypeName(String typeName) {
    final defaultValue = _defaultTypeValueMap[_getSanitizedTypeName(typeName)];
    // For all unknown optionals we can return null as a value
    if (defaultValue == null && _isOptional(typeName)) {
      return "null";
    } else {
      return defaultValue ?? '';
    }
  }

  static String _getSanitizedTypeName(String name) {
    var typeName = name;
    // This way we can give a one for all default value for Lists, Sets and Maps
    if (_isListSetOrMap(typeName)) {
      typeName = typeName.substring(0, typeName.indexOf('<'));
    }
    // All optionals get the default value of the type if it exists
    if (_isOptional(typeName)) {
      typeName = typeName.substring(0, typeName.indexOf('?'));
    }
    return typeName;
  }

  static bool _isListSetOrMap(String typeName) => typeName.contains('<');

  static bool _isOptional(String typeName) => typeName.contains('?');

  static bool _hasDefaultValueForRecord(RecordType recordType) {
    var hasValue = true;
    for (final fieldType in recordType.positionalFields) {
      hasValue = hasValue && hasDefaultValueForType(fieldType.type);
    }
    return hasValue;
  }

  static String _getDefaultValueForRecord(RecordType recordType) {
    final firstValue = getDefaultValueFor(recordType.positionalFields[0].type);
    final secondValue = getDefaultValueFor(recordType.positionalFields[1].type);
    return "($firstValue, $secondValue)";
  }
}
