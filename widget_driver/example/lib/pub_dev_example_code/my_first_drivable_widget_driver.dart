import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

part 'my_first_drivable_widget_driver.g.dart';

@GenerateTestDriver()
class MyFirstDrivableWidgetDriver extends WidgetDriver {
  int _count = 0;

  String get appBarTitle => 'Intro to WidgetDriver';

  String get counterTitle => 'Counter:';

  String get counterValue => '$_count';

  IconData get increaseActionIcon => Icons.add;

  IconData get resetActionIcon => Icons.restore;

  void increaseCounterAction() {
    _count += 1;
    notifyWidget();
  }

  void resetCounterAction() {
    _count = 0;
    notifyWidget();
  }
}
