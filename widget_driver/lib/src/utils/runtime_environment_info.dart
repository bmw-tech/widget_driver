import 'package:flutter/widgets.dart';

/// A callback which returns `true` if the current runtime is a `flutter test` run.
typedef IsRunningInTestCallback = bool Function();

/// A helper class which gives you info about
/// the environment for the current runtime.
class RuntimeEnvironmentInfo {
  // `flutter test` always installs `AutomatedTestWidgetsFlutterBinding`, on every
  // platform (including web, where there is no process environment to check instead).
  static const String _testBindingTypeName = 'AutomatedTestWidgetsFlutterBinding';

  final IsRunningInTestCallback _isRunningInTest;

  RuntimeEnvironmentInfo({
    IsRunningInTestCallback? isRunningInTest,
  }) : _isRunningInTest = isRunningInTest ?? _isRunningInTestBinding;

  static bool _isRunningInTestBinding() {
    return WidgetsBinding.instance.runtimeType.toString() == _testBindingTypeName;
  }

  /// Returns `true` if the current runtime is in a test environment and tests are running.
  bool isRunningInTestEnvironment() {
    bool isRunningInTest = false;
    assert(() {
      isRunningInTest = _isRunningInTest();
      return true;
    }());
    return isRunningInTest;
  }
}
