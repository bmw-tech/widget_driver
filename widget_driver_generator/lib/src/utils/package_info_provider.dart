import 'dart:convert';
import 'dart:io';

class PackageInfoProvider {
  final FileReader _fileReader;

  PackageInfoProvider({
    FileReader? fileReader,
  }) : _fileReader = fileReader ?? FileReader();

  /// Grabs the version string for widget_driver_generator from the pubspec.lock
  Future<String> getPackageVersionString() async {
    late String pubspecLockString;
    Directory workspaceDir = Directory('.').absolute;
    File pubspecFile = File('${workspaceDir.path}/pubspec.yaml');

    if (_hasWorkspace(pubspecFile)) {
      while (!_isWorkSpaceRoot(pubspecFile)) {
        workspaceDir = workspaceDir.parent.absolute;
        pubspecFile = File('${workspaceDir.path}/pubspec.yaml');
      }
      pubspecLockString = await _fileReader.readFile('${workspaceDir.path}/pubspec.lock');
    } else {
      pubspecLockString = await _fileReader.readFile('pubspec.lock');
    }

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

  bool _isWorkSpaceRoot(File pubspec) {
    if (!pubspec.existsSync()) {
      return false;
    }
    return pubspec.readAsLinesSync().where((e) => e.startsWith('workspace:')).isNotEmpty;
  }

  bool _hasWorkspace(File pubspec) {
    return pubspec
        .readAsLinesSync()
        .where(
          (e) => e.startsWith('resolution:'),
        )
        .isNotEmpty;
  }
}

class FileReader {
  Future<String> readFile(String filename) async {
    final file = File(filename);
    return await file.readAsString();
  }
}
