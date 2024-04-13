// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_account_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.2.0"

class _$TestRegisterAccountPageDriver extends TestDriver implements RegisterAccountPageDriver {
  @override
  String get pageTitle => 'Hello World';

  @override
  String get usernameTextFieldPlaceholder => 'Hello World';

  @override
  String? get usernameInputError => 'Hello World';

  @override
  String get registerButtonText => 'Hello World';

  @override
  bool get registerIsLoading => true;

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
