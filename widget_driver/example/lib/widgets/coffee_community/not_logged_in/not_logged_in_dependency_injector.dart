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
      create: (_) => _WidgetResolver(context).get(() => CreateUserService(locator: context.read)),
      child: child,
    );
  }
}

/// Here we use the `DependencyResolver` do help us provide a TestDefault value
/// which can be used when/if other widget adds this widget as a child,
/// and we don't want to force other widget tests to need to inject our dependency.
///
/// If we would not have wrapped the `CreateUserService(locator: context.read)` inside this
/// `Resolver`, then any parent widget under test, would need to provide the mock for this child.
/// But now since we use the `Resolver` here, all ancestor widgets, during testing,
/// can just ignore all dependencies which their children require. --> Leads to Widget Testing in isolation :-D
class _WidgetResolver extends DependencyResolver {
  _WidgetResolver(BuildContext context) : super(context);

  @override
  void registerTestDefaultFallbackValues() {
    registerTestDefaultBuilder<CreateUserService>(() => TestDefaultCreateUserService());
  }

  @override
  T? tryToGetDependencyFromBuildContext<T>(BuildContext context) {
    return null;
  }
}

class TestDefaultCreateUserService extends EmptyDefault implements CreateUserService {}
