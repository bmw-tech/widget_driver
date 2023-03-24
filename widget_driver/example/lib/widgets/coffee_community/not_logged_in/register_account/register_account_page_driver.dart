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

  @TestDriverDefaultValue('Register new account')
  String get pageTitle => _localization.registerNewAccount;

  @TestDriverDefaultValue('Enter your desired username')
  String get usernameTextFieldPlaceholder => _localization.createUsernameInputPlaceholder;

  @TestDriverDefaultValue(null)
  String? get usernameInputError => _usernameInputError;

  @TestDriverDefaultValue('Register and log in')
  String get registerButtonText => _localization.registerAndLogIn;

  @TestDriverDefaultValue(false)
  bool get registerIsLoading => _registerIsLoading;

  @TestDriverDefaultValue()
  void usernameInputChanged(String inputName) {
    _currentUsername = inputName;
    _validateUsernameInput();
  }

  @TestDriverDefaultFutureValue()
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
