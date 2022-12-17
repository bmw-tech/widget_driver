import 'platform_environment.dart';

/// A helper class which gives you info about
/// the environment for the current runtime.
class RuntimeEnvironmentInfo {
  static const String _flutterTestEnvKey = 'FLUTTER_TEST';

  final PlatformEnvironment _platformEnvironment;

  RuntimeEnvironmentInfo({
    PlatformEnvironment? platformEnvironment,
  }) : _platformEnvironment = platformEnvironment ?? PlatformEnvironment();

  /// Returns `true` if the current runtime is in a test environment and tests are running.
  bool isRunningInTestEnvironment() {
    return _platformEnvironment.containsKey(_flutterTestEnvKey);
  }
}
