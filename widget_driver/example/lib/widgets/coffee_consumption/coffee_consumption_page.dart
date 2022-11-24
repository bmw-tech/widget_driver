import 'package:flutter/material.dart';

import 'coffee_counter/coffee_counter_widget.dart';
import 'random_coffee_image_widget/random_coffee_image_widget.dart';

class CoffeeConsumptionPage extends StatelessWidget {
  const CoffeeConsumptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          CoffeeCounterWidget(),
          const SizedBox(height: 30),
          RandomCoffeeImageWidget(),
        ],
      ),
    );
  }
}
