import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'home_page/home_page.dart';
import 'my_app_driver.dart';

class MyApp extends DrivableWidget<MyAppDriver> {
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
  WidgetDriverProvider<MyAppDriver> get driverProvider =>
      $MyAppDriverProvider();
}
