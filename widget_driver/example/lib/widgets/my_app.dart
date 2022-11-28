import 'package:flutter/material.dart';

import 'home_page/home_page.dart';
import 'my_app_driver.dart';

class MyApp extends $MyAppDrivableWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: driver.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: HomePage(),
    );
  }

  @override
  $MyAppDriverProvider get driverProvider => $MyAppDriverProvider();
}
