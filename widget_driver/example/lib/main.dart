import 'package:flutter/material.dart';

import 'dependency_injection_manager.dart';
import 'widgets/my_app.dart';

void main() {
  DependencyInjectionManager.setup();
  runApp(const MyApp());
}
