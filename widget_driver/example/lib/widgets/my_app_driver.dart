import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../localization/localization.dart';
import '../resolver/resolver.dart';

part 'my_app_driver.g.dart';

@GenerateTestDriver()
class MyAppDriver extends WidgetDriver {
  late Localization _localization;

  @override
  void didUpdateBuildContext(BuildContext context) {
    _localization = Resolver(context).get(() => context.read<Localization>());
  }

  @TestDriverDefaultValue('Coffee Demo App')
  String get appTitle => _localization.appTitle;
}
