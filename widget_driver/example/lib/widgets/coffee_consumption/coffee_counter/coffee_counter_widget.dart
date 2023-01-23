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
          onPressed: driver.consumeCoffeeQuick,
          child: Text(driver.consumeCoffeeQuickButtonText),
        ),
        ElevatedButton(
          onPressed: () async {
            final didConsumeSlow = await driver.consumeCoffeeSlow();
            // ignore: avoid_print
            print('Did consume a slow coffee: $didConsumeSlow');
          },
          child: Text(driver.consumeCoffeeSlowButtonText),
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
  WidgetDriverProvider<CoffeeCounterWidgetDriver> get driverProvider => $CoffeeCounterWidgetDriverProvider();
}
