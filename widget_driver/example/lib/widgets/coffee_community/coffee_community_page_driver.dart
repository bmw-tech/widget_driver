import 'dart:async';

import 'package:example/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

part 'coffee_community_page_driver.g.dart';

@Driver()
class CoffeeCommunityPageDriver extends WidgetDriver {
  final AuthService _authService;
  StreamSubscription? _subscription;

  CoffeeCommunityPageDriver(BuildContext context)
      : _authService = context.read<AuthService>(),
        super(context) {
    _subscription = _authService.isLoggedInStream.listen((_) {
      notifyWidget();
    });
  }

  @DriverProperty(false)
  bool get isLoggedIn => _authService.isLoggedIn;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
