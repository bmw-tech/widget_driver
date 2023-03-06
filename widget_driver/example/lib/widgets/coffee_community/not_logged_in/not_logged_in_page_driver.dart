import 'package:example/services/create_user_service.dart';
import 'package:example/widgets/coffee_community/not_logged_in/register_account/register_account_page.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../coordinator/coordinator.dart';
import '../../../localization/localization.dart';

part 'not_logged_in_page_driver.g.dart';

@GenerateTestDriver()
class NotLoggedInPageDriver extends WidgetDriver {
  final Locator _locator;
  final Coordinator _coordinator;

  NotLoggedInPageDriver(
    BuildContext context, {
    Localization? localization,
    Coordinator? coordinator,
  })  : _locator = context.read,
        _coordinator = coordinator ?? Coordinator(),
        super(context);

  @TestDriverDefaultValue('Not logged in')
  String get notLoggedInText => _locator<Localization>().notLoggedIn;

  @TestDriverDefaultValue('Register a new account')
  String get registerNewAccountButtonText => _locator<Localization>().registerNewAccount;

  @TestDriverDefaultValue()
  void registerNewAccountTapped(BuildContext context) {
    _coordinator.pushMaterialPageRoute(
      context: context,
      builder: (_) {
        return Provider.value(
          value: context.watch<CreateUserService>(),
          child: RegisterAccountPage(),
        );
      },
    );
  }
}
