import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../services/auth_service.dart';

part 'log_in_out_button_driver.g.dart';

@Driver()
class LogInOutButtonDriver extends WidgetDriver {
  late AuthService _authService;
  StreamSubscription? _subscription;

  @override
  void setUpFromBuildContext(BuildContext context) {
    _authService = context.read<AuthService>();
    _subscription = _authService.isLoggedInStream.listen((_) {
      notifyWidget();
    });
  }

  @DriverProperty(Icons.logout_rounded)
  IconData get buttonIcon {
    return _authService.isLoggedIn ? Icons.logout_rounded : Icons.login_rounded;
  }

  @DriverAction()
  void toggleLogInOut() {
    if (_authService.isLoggedIn) {
      _authService.logOut();
    } else {
      _authService.logIn();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
