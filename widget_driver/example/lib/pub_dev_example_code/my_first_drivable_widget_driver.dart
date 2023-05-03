import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

part 'my_first_drivable_widget_driver.g.dart';

@GenerateTestDriver()
class MyFirstDrivableWidgetDriver extends WidgetDriver {
  int _count = 0;

  @TestDriverDefaultValue('The app bar title')
  String get appBarTitle => 'Intro to WidgetDriver';

  @TestDriverDefaultValue('Counter:')
  String get counterTitle => 'Counter:';

  @TestDriverDefaultValue('0')
  String get counterValue => '$_count';

  @TestDriverDefaultValue(Icons.add)
  IconData get increaseActionIcon => Icons.add;

  @TestDriverDefaultValue(Icons.restore)
  IconData get resetActionIcon => Icons.restore;

  @TestDriverDefaultValue()
  void increaseCounterAction() {
    _count += 1;
    notifyWidget();
  }

  @TestDriverDefaultValue()
  void resetCounterAction() {
    _count = 0;
    notifyWidget();
  }
}
