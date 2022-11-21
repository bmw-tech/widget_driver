import 'package:flutter/material.dart';

import 'coffee_community_page_driver.dart';

class CoffeeCommunityPage extends $CoffeeCommunityPageDrivableWidget {
  CoffeeCommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("Hello");
  }

  @override
  $CoffeeCommunityPageDriverProvider get driverProvider => $CoffeeCommunityPageDriverProvider();
}
