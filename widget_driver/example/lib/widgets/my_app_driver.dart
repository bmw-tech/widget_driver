import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../localization/localization.dart';

part 'my_app_driver.g.dart';

@GenerateTestDriver()
class MyAppDriver extends WidgetDriver {
  final Locator _localizationLocator;

  MyAppDriver(BuildContext context)
      : _localizationLocator = context.read,
        super(context);

  @TestDriverDefaultValue('Coffee Demo App')
  String get appTitle => _localizationLocator<Localization>().appTitle;
}
