import 'dart:io';

import 'package:flutter/foundation.dart';

/// A helper class which gives you info about the current runtime.
class FlutterRuntimeEnvironmentInfo {
  /// Returns `true` if the current runtime is in a test environment and tests are running.
  bool isRunningInTestEnvironment() {
    if (_isRunningForWeb()) {
      // Web does not support `Platform.environment`
      // So when we cannot check that to see if we are running test.
      // But when we are running for web, then we know that we are not testing,
      // so then we can just return false here
      return false;
    }

    return Platform.environment.containsKey('FLUTTER_TEST');
  }

  bool _isRunningForWeb() {
    return kIsWeb;
  }
}
