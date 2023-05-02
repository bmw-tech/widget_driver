import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'my_first_drivable_widget_driver.dart';

class MyFirstDrivableWidget extends DrivableWidget<MyFirstDrivableWidgetDriver> {
  MyFirstDrivableWidget({Key? key}) : super(key: key);

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(title: Text(driver.appBarTitle)),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: driver.increaseCounterAction,
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: driver.resetCounterAction,
            child: const Icon(Icons.restore),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text(driver.counterTitle, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text(driver.counterValue, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  @override
  WidgetDriverProvider<MyFirstDrivableWidgetDriver> get driverProvider => $MyFirstDrivableWidgetDriverProvider();
}
