import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../services/create_user_service.dart';

class NotLoggedInDependencyInjector extends StatelessWidget {
  final Widget child;

  const NotLoggedInDependencyInjector({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => _DependencyProvider().get(() => CreateUserService(locator: context.read)),
      child: child,
    );
  }
}

class _DependencyProvider extends DependencyProvider {
  @override
  void registerTestDefaultFallbackValues() {
    registerTestDefaultBuilder<CreateUserService>(() => TestDefaultCreateUserService());
  }
}

class TestDefaultCreateUserService extends EmptyDefault implements CreateUserService {}
