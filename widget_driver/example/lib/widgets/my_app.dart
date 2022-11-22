import 'package:example/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Driver Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Provider(
        create: (_) => AuthService(),
        child: HomePage(),
      ),
    );
  }
}
