// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_account_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "0.2.0"

class _$TestRegisterAccountPageDriver extends TestDriver implements RegisterAccountPageDriver {
  @override
  String get pageTitle => 'Register new account';

  @override
  String get usernameTextFieldPlaceholder => 'Enter your desired username';

  @override
  String? get usernameInputError => null;

  @override
  String get registerButtonText => 'Register and log in';

  @override
  bool get registerIsLoading => false;

  @override
  void usernameInputChanged(String inputName) {}

  @override
  Future<void> tappedRegister(BuildContext context) {
    return Future.value();
  }
}

class $RegisterAccountPageDriverProvider extends WidgetDriverProvider<RegisterAccountPageDriver> {
  @override
  RegisterAccountPageDriver buildDriver() {
    return RegisterAccountPageDriver();
  }

  @override
  RegisterAccountPageDriver buildTestDriver() {
    return _$TestRegisterAccountPageDriver();
  }
}
