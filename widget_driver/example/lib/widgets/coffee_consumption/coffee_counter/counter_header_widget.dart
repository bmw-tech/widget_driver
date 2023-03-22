import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'counter_header_widget_driver.dart';

class CounterHeaderWidget extends DrivableWidget<CounterHeaderWidgetDriver> {
  CounterHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(driver.descriptionText),
        Text(driver.amountText),
      ],
    );
  }

  @override
  WidgetDriverProvider<CounterHeaderWidgetDriver> get driverProvider => $CounterHeaderWidgetDriverProvider();
}
