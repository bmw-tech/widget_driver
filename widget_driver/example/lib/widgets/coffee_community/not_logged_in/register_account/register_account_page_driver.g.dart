// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_account_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.0.3"

class _$TestRegisterAccountPageDriver extends TestDriver implements RegisterAccountPageDriver {
  @override
  String get pageTitle => '';

  @override
  String get usernameTextFieldPlaceholder => '';

  @override
  String? get usernameInputError => '';

  @override
  String get registerButtonText => '';

  @override
  bool get registerIsLoading => false;

  @override
  void didUpdateBuildContext(BuildContext context) {}

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
