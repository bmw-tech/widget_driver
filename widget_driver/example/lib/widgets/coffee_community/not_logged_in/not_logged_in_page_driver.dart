import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';

part 'not_logged_in_page_driver.g.dart';

@Driver()
class NotLoggedInPageDriver extends WidgetDriver {
  final Localization _localization;

  NotLoggedInPageDriver(BuildContext context)
      : _localization = context.read<Localization>(),
        super(context);

  @DriverProperty('Not logged in')
  String get notLoggedInText => _localization.notLoggedIn;
}
