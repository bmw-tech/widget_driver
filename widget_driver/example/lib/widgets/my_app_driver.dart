import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../localization/localization.dart';

part 'my_app_driver.g.dart';

@GenerateTestDriver()
class MyAppDriver extends WidgetDriver {
  final Locator _locator;

  MyAppDriver(BuildContext context)
      : _locator = context.read,
        super(context);

  @TestDriverDefaultValue('Coffee Demo App')
  String get appTitle => _locator<Localization>().appTitle;

  @override
  void didUpdateBuildContextDependencies(BuildContext context) {}
}
