import 'package:example/services/create_user_service.dart';
import 'package:example/widgets/coffee_community/not_logged_in/register_account/register_account_page.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../coordinator/coordinator.dart';
import '../../../localization/localization.dart';

part 'not_logged_in_page_driver.g.dart';

@GenerateTestDriver()
class NotLoggedInPageDriver extends WidgetDriver {
  late Localization _localization;
  final Coordinator _coordinator;

  NotLoggedInPageDriver({
    Coordinator? coordinator,
  }) : _coordinator = coordinator ?? Coordinator();

  @override
  void didUpdateBuildContext(BuildContext context) {
    _localization = context.read<Localization>();
  }

  String get notLoggedInText => _localization.notLoggedIn;

  String get registerNewAccountButtonText => _localization.registerNewAccount;

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
