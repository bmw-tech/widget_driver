import 'package:example/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

part 'coffee_community_page_driver.g.dart';

@Driver()
class CoffeeCommunityPageDriver extends WidgetDriver {
  late AuthService _authService;

  @override
  void initWithBuildContext(BuildContext context) {
    _authService = context.read<AuthService>();
    _authService.isLoggedInStream.listen((_) {
      notifyWidget();
    });
  }

  @DriverProperty("You are logged in!")
  String get isLoggedInTitle {
    if (_authService.isLoggedIn) {
      return "You are logged in!";
    } else {
      return "You are NOT logged in!";
    }
  }
}
