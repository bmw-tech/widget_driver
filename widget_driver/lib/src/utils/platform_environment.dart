import 'dart:io';

import 'package:flutter/foundation.dart';

/// The [Platform] contains helper functions to check which
/// platform we are running on. E.g. `isIOS`, `isAndroid` etc.
/// But for some reason it does not contain the info if we are running on web.
/// So this extension adds a helper function which returns this info.
extension WebPlatformInfo on Platform {
  static bool get isWeb => kIsWeb;
}

/// A callback which provides the current runtime environment as a 'Map<String, String>'
/// where the key is the name of an environment variable and the value is its current value.
typedef EnvironmentCallback = Map<String, String> Function();

/// A wrapper class around [Platform.environment] for getting
/// information about the environment for the current platform process.
///
/// In the default [Platform] when you are running for 'Web'
/// and you try to access the [Platform.environment] then an
/// exception is thrown since `Web` does not support `environment`.
/// This wrapper class takes care of this and just ignores environment requests
/// made when running as `Web`.
class PlatformEnvironment {
  final bool _isWeb;
  final EnvironmentCallback _getEnvironment;

  PlatformEnvironment({
    bool? isWeb,
    EnvironmentCallback? getEnvironment,
  })  : _isWeb = isWeb ?? WebPlatformInfo.isWeb,
        _getEnvironment = getEnvironment ?? (() => Platform.environment);

  bool containsKey(Object? key) {
    if (_platformSupportsEnvironmentVariables()) {
      return _getEnvironment().containsKey(key);
    } else {
      return false;
    }
  }

  bool _platformSupportsEnvironmentVariables() {
    return !_isWeb;
  }
}
