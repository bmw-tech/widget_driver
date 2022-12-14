import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../localization/localization.dart';
import 'tabs/home_page_tabs.dart';

part 'home_page_driver.g.dart';

@Driver()
class HomePageDriver extends WidgetDriver {
  final HomePageAppTabs _appTabs;
  late final Localization _localization;

  HomePageDriver(
    BuildContext context, {
    HomePageAppTabs? appTabs,
  })  : _appTabs = appTabs ?? HomePageAppTabs(),
        _localization = context.read<Localization>(),
        super(context);

  @DriverProperty('Coffee Demo App')
  String get title => _localization.appTitle;

  @DriverProperty(2)
  int get numberOfTabs {
    return _appTabs.tabs.length;
  }

  @DriverProperty([AppTabType.consumption, AppTabType.community])
  List<AppTabType> get appTabs => _appTabs.tabs;
}
