import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../localization/localization.dart';
import 'tabs/home_page_tabs.dart';

part 'home_page_driver.g.dart';

@GenerateTestDriver()
class HomePageDriver extends WidgetDriver {
  final HomePageAppTabs _appTabs;
  final Locator _localizationLocator;

  HomePageDriver(
    BuildContext context, {
    HomePageAppTabs? appTabs,
  })  : _appTabs = appTabs ?? HomePageAppTabs(),
        _localizationLocator = context.read,
        super(context);

  @TestDriverDefaultValue('Coffee Demo App')
  String get title => _localizationLocator<Localization>().appTitle;

  @TestDriverDefaultValue(2)
  int get numberOfTabs {
    return _appTabs.tabs.length;
  }

  @TestDriverDefaultValue([AppTabType.consumption, AppTabType.community])
  List<AppTabType> get appTabs => _appTabs.tabs;
}
