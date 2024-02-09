import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'playground_test_child_widget_driver.dart';

class PlaygroundTestChildWidget extends DrivableWidget<PlaygroundTestChildWidgetDriver> {
  PlaygroundTestChildWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(driver.theText);
  }

  @override
  WidgetDriverProvider<PlaygroundTestChildWidgetDriver> get driverProvider =>
      $PlaygroundTestChildWidgetDriverProvider();
}
