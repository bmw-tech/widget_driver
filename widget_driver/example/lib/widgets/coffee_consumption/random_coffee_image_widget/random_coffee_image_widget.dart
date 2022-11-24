import 'package:flutter/material.dart';

import '../../custom_widgets/cached_network_image.dart';
import 'random_coffee_image_widget_driver.dart';

class RandomCoffeeImageWidget extends $RandomCoffeeImageDrivableWidget {
  RandomCoffeeImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(driver.title),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => driver.updateRandomImage(),
          child: CachedNetworkImage(imageUrl: driver.coffeeImageUrl),
        ),
      ],
    );
  }

  @override
  $RandomCoffeeImageWidgetDriverProvider get driverProvider => $RandomCoffeeImageWidgetDriverProvider();
}
