import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../localization/localization.dart';

part 'my_app_driver.g.dart';

@Driver()
class MyAppDriver extends WidgetDriver {
  late final Localization _localization;

  @override
  void setUpFromBuildContext(BuildContext context) {
    _localization = context.read<Localization>();
  }

  @DriverProperty('Coffee Demo App')
  String get appTitle => _localization.appTitle;
}
