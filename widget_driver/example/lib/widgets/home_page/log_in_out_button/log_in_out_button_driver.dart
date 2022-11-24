import 'dart:async';

import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';
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

  @DriverProperty('Log in')
  String get buttonText {
    return _authService.isLoggedIn ? Localization.logOut : Localization.logIn;
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
