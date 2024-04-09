import 'package:example/models/coffee.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../localization/localization.dart';
import '../../resolver/resolver.dart';
import 'tabs/home_page_tabs.dart';

part 'home_page_driver.g.dart';

@GenerateTestDriver()
class HomePageDriver extends WidgetDriver {
  final HomePageAppTabs _appTabs;
  late Localization _localization;

  HomePageDriver({HomePageAppTabs? appTabs}) : _appTabs = appTabs ?? HomePageAppTabs();

  @override
  void didUpdateBuildContext(BuildContext context) {
    _localization = Resolver(context).get(() => context.read<Localization>());
  }

  String get title => _localization.appTitle;

  int get numberOfTabs {
    return _appTabs.tabs.length;
  }

  List<AppTabType> get appTabs => _appTabs.tabs;
}
