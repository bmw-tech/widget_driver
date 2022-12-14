import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'log_in_out_button_driver.dart';

class LogInOutButton extends DrivableWidget<LogInOutButtonDriver> {
  LogInOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => driver.toggleLogInOut(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(driver.buttonText),
          ),
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<LogInOutButtonDriver> get driverProvider => $LogInOutButtonDriverProvider();
}
