// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_account_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version: 1.0.0+1

class _$TestRegisterAccountPageDriver extends TestDriver implements RegisterAccountPageDriver {
  @override
  String get pageTitle => 'Register new account';

  @override
  String get usernameTextFieldPlaceholder => 'Enter your desired username';

  @override
  String? get usernameInputError => null;

  @override
  void usernameInputChanged(String inputName) {}

  @override
  Future<void> tappedRegister(BuildContext context) async {}
}

class $RegisterAccountPageDriverProvider extends WidgetDriverProvider<RegisterAccountPageDriver> {
  @override
  RegisterAccountPageDriver buildDriver(BuildContext context) {
    return RegisterAccountPageDriver(context);
  }

  @override
  RegisterAccountPageDriver buildTestDriver() {
    return _$TestRegisterAccountPageDriver();
  }
}
