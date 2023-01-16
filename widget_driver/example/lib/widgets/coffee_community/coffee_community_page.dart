import 'package:example/widgets/coffee_community/coffee_library/coffee_library_page.dart';
import 'package:example/widgets/coffee_community/not_logged_in/not_logged_in_page.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'coffee_community_page_driver.dart';

class CoffeeCommunityPage extends DrivableWidget<CoffeeCommunityPageDriver> {
  CoffeeCommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (driver.isLoggedIn) {
      return CoffeeLibraryPage();
    } else {
      return NotLoggedInPage();
    }
  }

  @override
  WidgetDriverProvider<CoffeeCommunityPageDriver> get driverProvider =>
      $CoffeeCommunityPageDriverProvider();
}
