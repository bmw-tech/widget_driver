import 'package:flutter/material.dart';

class HomePageAppTabs {
  final List<AppTabType> tabs = [AppTabType.consumption, AppTabType.community];
}

enum AppTabType { consumption, community }

extension IconProvider on AppTabType {
  IconData get iconData {
    switch (this) {
      case AppTabType.consumption:
        return Icons.coffee;
      case AppTabType.community:
        return Icons.people;
    }
  }
}
