import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'coffee_counter_header_section_driver.dart';

class CoffeeCounterHeaderSection extends DrivableWidget<CoffeeCounterHeaderSectionDriver> {
  CoffeeCounterHeaderSection({Key? key}) : super(key: key);

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
  WidgetDriverProvider<CoffeeCounterHeaderSectionDriver> get driverProvider =>
      $CoffeeCounterHeaderSectionDriverProvider();
}
