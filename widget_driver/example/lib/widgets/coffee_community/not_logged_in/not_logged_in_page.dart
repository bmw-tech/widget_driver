import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'not_logged_in_page_driver.dart';

class NotLoggedInPage extends DrivableWidget<NotLoggedInPageDriver> {
  NotLoggedInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(driver.notLoggedInText));
  }

  @override
  WidgetDriverProvider<NotLoggedInPageDriver> get driverProvider =>
      $NotLoggedInPageDriverProvider();
}
