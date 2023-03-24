import 'dart:async';

import 'package:example/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

part 'coffee_community_page_driver.g.dart';

@GenerateTestDriver()
class CoffeeCommunityPageDriver extends WidgetDriver {
  late AuthService _authService;
  StreamSubscription? _subscription;

  @override
  void didUpdateBuildContext(BuildContext context) {
    _authService = context.read<AuthService>();

    // If you would have grabbed something here using `context.watch`
    // then the `didUpdateBuildContext` method could get called more times.
    // In these cases you need to clean up previous state.
    // E.g. by calling `cancel()` on a previous subscription.
    //
    // _subscription?.cancel();
    //
    // But here we do not need to do this since we are only reading the dependency
    // out of the context. So in this case, we know that the
    // `didUpdateBuildContext` is only called once.

    _subscription = _authService.isLoggedInStream.listen((_) {
      notifyWidget();
    });
  }

  @TestDriverDefaultValue(false)
  bool get isLoggedIn => _authService.isLoggedIn;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
