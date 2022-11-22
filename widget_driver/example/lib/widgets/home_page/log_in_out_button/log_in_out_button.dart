import 'package:flutter/material.dart';

import 'log_in_out_button_driver.dart';

class LogInOutButton extends $LogInOutButtonDrivableWidget {
  LogInOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => driver.toggleLogInOut(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(driver.buttonIcon),
      ),
    );
  }

  @override
  $LogInOutButtonDriverProvider get driverProvider =>
      $LogInOutButtonDriverProvider();
}
