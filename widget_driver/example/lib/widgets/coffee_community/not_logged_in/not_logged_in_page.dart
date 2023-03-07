import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'not_logged_in_page_driver.dart';

class NotLoggedInPage extends DrivableWidget<NotLoggedInPageDriver> {
  NotLoggedInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(driver.notLoggedInText),
        ),
        ElevatedButton(
          onPressed: () => driver.registerNewAccountTapped(context),
          child: Text(driver.registerNewAccountButtonText),
        ),
      ],
    );
  }

  @override
  WidgetDriverProvider<NotLoggedInPageDriver> get driverProvider => $NotLoggedInPageDriverProvider();
}
