import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';

part 'not_logged_in_page_driver.g.dart';

@Driver()
class NotLoggedInPageDriver extends WidgetDriver {
  late final Localization _localization;

  @override
  void setUpFromBuildContext(BuildContext context) {
    _localization = context.read<Localization>();
  }

  @DriverProperty('Not logged in')
  String get notLoggedInText => _localization.notLoggedIn;
}
