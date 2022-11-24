import 'package:flutter/material.dart';
import 'package:example/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'dependency_injection_manager.dart';
import 'localization/localization.dart';
import 'widgets/my_app.dart';

void main() {
  DependencyInjectionManager.setup();
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => AuthService()),
      Provider(create: (_) => Localization()),
    ],
    child: MyApp(),
  ));
}
