import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';

part 'not_logged_in_page_driver.g.dart';

@GenerateTestDriver()
class NotLoggedInPageDriver extends WidgetDriver {
  final Locator _localizationLocator;

  NotLoggedInPageDriver(BuildContext context)
      : _localizationLocator = context.read,
        super(context);

  @TestDriverDefaultValue('Not logged in')
  String get notLoggedInText => _localizationLocator<Localization>().notLoggedIn;
}
