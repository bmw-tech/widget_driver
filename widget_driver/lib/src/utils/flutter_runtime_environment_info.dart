import 'dart:io';

/// A helper class which gives you info about the current runtime.
class FlutterRuntimeEnvironmentInfo {
  /// Returns `true` if the current runtime is in a test environment and tests are running.
  bool isRunningInTestEnvironment() {
    return Platform.environment.containsKey('FLUTTER_TEST');
  }
}
