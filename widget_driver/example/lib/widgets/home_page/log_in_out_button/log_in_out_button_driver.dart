import 'dart:async';

import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';
import '../../../services/auth_service.dart';

part 'log_in_out_button_driver.g.dart';

@GenerateTestDriver()
class LogInOutButtonDriver extends WidgetDriver {
  late AuthService _authService;
  late Localization _localization;
  StreamSubscription? _subscription;

  @override
  void didUpdateBuildContext(BuildContext context) {
    _localization = context.read<Localization>();
    _authService = context.watch<AuthService>();
    _subscription = _authService.isLoggedInStream.listen((_) {
      notifyWidget();
    });
  }

  @TestDriverDefaultValue('Log in')
  String get buttonText {
    return _authService.isLoggedIn ? _localization.logOut : _localization.logIn;
  }

  @TestDriverDefaultValue()
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
