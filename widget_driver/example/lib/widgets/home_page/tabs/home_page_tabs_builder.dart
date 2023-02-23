import 'package:flutter/material.dart';

import '../../coffee_community/coffee_community_page.dart';
import '../../coffee_consumption/coffee_consumption_page.dart';
import '../../playground/playground_page.dart';
import 'home_page_tabs.dart';

class HomePageTabBuilder {
  static Widget tabForType(AppTabType type) {
    switch (type) {
      case AppTabType.consumption:
        return const CoffeeConsumptionPage();
      case AppTabType.community:
        return CoffeeCommunityPage();
      case AppTabType.playground:
        return const PlaygroundPage();
    }
  }
}
