extension StringExtension on String {
  /// Removes a leading `_`, if it exists.
  String removeLeadingUnderscore() => startsWith('_') && length > 0 ? substring(1) : this;

  /// Capitalizes the first letter of the String
  /// ```dart
  /// 'alphabet'.capitalizeFirstLetter(); // 'Alphabet'
  /// 'ABC'.capitalizeFirstLetter(); // 'ABC'
  /// 'someString'.capitalizeFirstLetter(); // 'SomeString'
  /// ```
  String capitalizeFirstLetter() => length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : this;

  /// Adds `new` at the beginning of the string, while also capitalizing the original begining of the String.
  /// ```dart
  /// 'alphabet'.makeItNew(); // 'newAlphabet'
  /// 'ABC'.makeItNew(); // 'newABC'
  /// 'someString'.makeItNew(); // 'newSomeString'
  /// ```
  String makeItNew() => length > 0 ? 'new${capitalizeFirstLetter()}' : this;
}
