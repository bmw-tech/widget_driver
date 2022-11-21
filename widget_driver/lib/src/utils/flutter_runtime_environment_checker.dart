import 'dart:io';

class FlutterRuntimeEnvironmentChecker {
  bool isRunningInTestEnvironment() {
    return Platform.environment.containsKey('FLUTTER_TEST');
  }
}
