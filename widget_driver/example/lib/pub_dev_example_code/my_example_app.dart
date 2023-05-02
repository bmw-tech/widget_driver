import 'package:flutter/material.dart';

import 'my_first_drivable_widget.dart';

/// This widget is used for the example app in the pub.dev example readme
class MyExampleReadMeApp extends StatelessWidget {
  const MyExampleReadMeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WidgetDriver intro demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyFirstDrivableWidget(),
    );
  }
}
