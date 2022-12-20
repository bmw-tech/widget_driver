import 'dart:io';

import 'package:flutter/foundation.dart';

/// The [Platform] contains helper functions to check which
/// platform we are running on. E.g. `isIOS`, `isAndroid` etc.
/// But for some reason it does not contain the info if we are running on web.
/// So this extension adds a helper function which returns this info.
extension WebPlatformInfo on Platform {
  static bool get isWeb => kIsWeb;
}

typedef GetEnvironment = Map<String, String> Function();

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
  final GetEnvironment _getEnvironment;

  PlatformEnvironment({
    bool? isWeb,
    GetEnvironment? getEnvironment,
  })  : _isWeb = isWeb ?? WebPlatformInfo.isWeb,
        _getEnvironment = getEnvironment ?? (() => Platform.environment);

  bool containsKey(Object? key) {
    if (_doesPlatformSupportEnvironmentVariables()) {
      return _getEnvironment().containsKey(key);
    } else {
      return false;
    }
  }

  bool _doesPlatformSupportEnvironmentVariables() {
    if (_isWeb) {
      return false;
    } else {
      return true;
    }
  }
}
