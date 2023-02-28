import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../localization/localization.dart';

part 'my_app_driver.g.dart';

@GenerateTestDriver()
class MyAppDriver extends WidgetDriver {
  final Localization _localization;

  MyAppDriver(BuildContext context)
      : _localization = context.read<Localization>(),
        super(context);

  @TestDriverDefaultValue('Coffee Demo App')
  String get appTitle => _localization.appTitle;
}
