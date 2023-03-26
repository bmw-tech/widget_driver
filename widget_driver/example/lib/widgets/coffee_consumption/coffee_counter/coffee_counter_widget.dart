import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import 'coffee_counter_header_section.dart';
import 'coffee_counter_widget_driver.dart';

class CoffeeCounterWidget extends DrivableWidget<CoffeeCounterWidgetDriver> {
  CoffeeCounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Provider.value(value: driver.coffeeCount, child: CoffeeCounterHeaderSection()),
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
