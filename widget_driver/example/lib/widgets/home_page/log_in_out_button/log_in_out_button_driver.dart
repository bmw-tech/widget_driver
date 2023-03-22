import 'dart:async';

import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';
import '../../../services/auth_service.dart';

part 'log_in_out_button_driver.g.dart';

@GenerateTestDriver()
class LogInOutButtonDriver extends WidgetDriver {
  final AuthService _authService;
  final Locator _locator;
  StreamSubscription? _subscription;

  LogInOutButtonDriver(BuildContext context)
      : _authService = context.read<AuthService>(),
        _locator = context.read,
        super(context) {
    _subscription = _authService.isLoggedInStream.listen((_) {
      notifyWidget();
    });
  }

  @TestDriverDefaultValue('Log in')
  String get buttonText {
    return _authService.isLoggedIn ? _localization().logOut : _localization().logIn;
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

  Localization _localization() => _locator<Localization>();

  @override
  void didUpdateBuildContextDependencies(BuildContext context) {}
}
