import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'random_coffee_image_widget_driver.dart';

class RandomCoffeeImageWidget extends $RandomCoffeeImageDrivableWidget {
  RandomCoffeeImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => driver.updateRandomImage(),
      child: CachedNetworkImage(
        imageUrl: driver.coffeeImageUrl,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        height: 300,
        fit: BoxFit.fill,
        fadeInDuration: const Duration(milliseconds: 400),
        fadeOutDuration: const Duration(milliseconds: 700),
      ),
    );
  }

  @override
  $RandomCoffeeImageWidgetDriverProvider get driverProvider => $RandomCoffeeImageWidgetDriverProvider();
}
