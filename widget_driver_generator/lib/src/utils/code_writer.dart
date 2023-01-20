/// Use this class to create code from strings
class CodeWriter {
  final StringBuffer classBuffer = StringBuffer();

  /// Adds the passed in string based code to the current code base.
  /// New code is added below existing code.
  void writeCode(String code) {
    classBuffer.writeln(code);
  }

  /// Get all existing code.
  String getAllCode() {
    return classBuffer.toString();
  }
}
