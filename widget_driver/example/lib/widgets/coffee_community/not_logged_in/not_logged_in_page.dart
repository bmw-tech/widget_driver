import 'package:flutter/material.dart';

import 'not_logged_in_page_driver.dart';

class NotLoggedInPage extends $NotLoggedInPageDrivableWidget {
  NotLoggedInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(driver.notLoggedInText));
  }

  @override
  $NotLoggedInPageDriverProvider get driverProvider => $NotLoggedInPageDriverProvider();
}
