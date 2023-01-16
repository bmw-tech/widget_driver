import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'coffee_counter_widget_driver.dart';

class CoffeeCounterWidget extends DrivableWidget<CoffeeCounterWidgetDriver> {
  CoffeeCounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(driver.descriptionText),
        Text(driver.amountText),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: driver.consumeCoffee,
          child: Text(driver.consumeCoffeeButtonText),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ElevatedButton(
            onPressed: driver.resetConsumption,
            child: Text(driver.resetCoffeeButtonText),
          ),
        )
      ],
    );
  }

  @override
  WidgetDriverProvider<CoffeeCounterWidgetDriver> get driverProvider =>
      $CoffeeCounterWidgetDriverProvider();
}
