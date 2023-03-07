import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'register_account_page_driver.dart';

class RegisterAccountPage extends DrivableWidget<RegisterAccountPageDriver> {
  RegisterAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(driver.pageTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: driver.usernameTextFieldPlaceholder,
                  errorText: driver.usernameInputError),
              onChanged: driver.usernameInputChanged,
            ),
          ),
          ElevatedButton(
            onPressed: (() => driver.tappedRegister(context)),
            child: driver.registerIsLoading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
                  )
                : Text(driver.registerButtonText),
          ),
        ],
      ),
    );
  }

  @override
  WidgetDriverProvider<RegisterAccountPageDriver> get driverProvider => $RegisterAccountPageDriverProvider();
}
