import 'package:flutter/material.dart';
import 'package:example/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'dependency_injection_manager.dart';

import 'widgets/my_app.dart';

void main() {
  DependencyInjectionManager.setup();
  runApp(Provider(
    create: (_) => AuthService(),
    child: const MyApp(),
  ));
}
