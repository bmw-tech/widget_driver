import 'package:flutter/material.dart';

import 'coffee_counter_widget_driver.dart';

class CoffeeCounterWidget extends $CoffeeCounterDrivableWidget {
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
        const SizedBox(width: 30),
        ElevatedButton(
          onPressed: driver.resetConsumption,
          child: Text(driver.resetCoffeeButtonText),
        )
      ],
    );
  }

  @override
  $CoffeeCounterWidgetDriverProvider get driverProvider => $CoffeeCounterWidgetDriverProvider();
}
