import 'package:widget_driver/widget_driver.dart';

import 'tabs/home_page_tabs.dart';

part 'home_page_driver.g.dart';

@Driver()
class HomePageDriver extends WidgetDriver {
  final HomePageAppTabs _appTabs;

  HomePageDriver({
    HomePageAppTabs? appTabs,
  }) : _appTabs = appTabs ?? HomePageAppTabs();

  @DriverProperty("Coffee Demo App")
  final String title = "Coffee Demo App";

  @DriverProperty(2)
  int get numberOfTabs {
    return _appTabs.tabs.length;
  }

  @DriverProperty([AppTabType.consumption, AppTabType.community])
  List<AppTabType> get appTabs => _appTabs.tabs;
}
