import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../../coordinator/coordinator.dart';
import '../../../../localization/localization.dart';
import '../../../../services/create_user_service.dart';

part 'register_account_page_driver.g.dart';

@GenerateTestDriver()
class RegisterAccountPageDriver extends WidgetDriver {
  late Localization _localization;
  late CreateUserService _createUserService;
  final Coordinator _coordinator;

  String _currentUsername = '';
  String? _usernameInputError;
  bool _registerIsLoading = false;

  RegisterAccountPageDriver({
    Coordinator? coordinator,
  }) : _coordinator = coordinator ?? Coordinator();

  @override
  void didUpdateBuildContext(BuildContext context) {
    _localization = context.read<Localization>();
    _createUserService = context.read<CreateUserService>();
  }

  String get pageTitle => _localization.registerNewAccount;

  String get usernameTextFieldPlaceholder => _localization.createUsernameInputPlaceholder;

  String? get usernameInputError => _usernameInputError;

  String get registerButtonText => _localization.registerAndLogIn;

  bool get registerIsLoading => _registerIsLoading;

  void usernameInputChanged(String inputName) {
    _currentUsername = inputName;
    _validateUsernameInput();
  }

  Future<void> tappedRegister(BuildContext context) async {
    if (_createUserService.isUserValidName(_currentUsername)) {
      _setRegisterLoading(true);
      await _createUserService.createUserAndLogin(_currentUsername);
      _setRegisterLoading(false);
      _coordinator.pop(context: context);
    } else {
      _validateUsernameInput();
    }
  }

  void _validateUsernameInput() {
    final wasShowingInputError = _isShowingInputError();
    if (_createUserService.isUserValidName(_currentUsername)) {
      _usernameInputError = null;
    } else {
      _usernameInputError = _localization.createUsernameInputNotValid;
    }

    if (wasShowingInputError != _isShowingInputError()) {
      notifyWidget();
    }
  }

  bool _isShowingInputError() {
    return _usernameInputError != null;
  }

  void _setRegisterLoading(bool isLoading) {
    _registerIsLoading = isLoading;
    notifyWidget();
  }
}
