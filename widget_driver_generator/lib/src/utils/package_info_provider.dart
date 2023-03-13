import 'dart:convert';
import 'dart:io';

class PackageInfoProvider {
  final FileReader _fileReader;

  PackageInfoProvider({
    FileReader? fileReader,
  }) : _fileReader = fileReader ?? FileReader();

  /// Grabs the version string for widget_driver_generator from the pubspec.lock
  Future<String> getPackageVersionString() async {
    final pubspecLockString = await _fileReader.readFile('pubspec.lock');

    final packageStartIndex = pubspecLockString.indexOf('widget_driver_generator:');
    if (packageStartIndex < 0) {
      return '';
    }
    final nextVersionIndex = pubspecLockString.indexOf('version:', packageStartIndex);
    if (nextVersionIndex < 0) {
      return '';
    }
    final endOfVersionIndex = nextVersionIndex + 'version:'.length + 1;

    final stringToCheck = pubspecLockString.substring(endOfVersionIndex);
    final versionNumberString = const LineSplitter().convert(stringToCheck).first;
    return versionNumberString;
  }
}

class FileReader {
  Future<String> readFile(String filename) async {
    final file = File(filename);
    return await file.readAsString();
  }
}
