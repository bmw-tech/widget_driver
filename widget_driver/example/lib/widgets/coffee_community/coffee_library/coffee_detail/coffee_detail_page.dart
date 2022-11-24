import 'package:example/widgets/coffee_community/coffee_library/coffee_detail/coffee_detail_page_driver.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CoffeeDetailPage extends $CoffeeDetailPageDrivableWidget {
  CoffeeDetailPage({Key? key}) : super(key: key);

  // TODO: Add real logic here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("driver.title"),
      ),
      body: Column(
        children: [
          const Text("Hello"),
          CachedNetworkImage(
            imageUrl: driver.coffeeImageUrl,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            height: 300,
            fit: BoxFit.fill,
            fadeInDuration: const Duration(milliseconds: 400),
            fadeOutDuration: const Duration(milliseconds: 700),
          )
        ],
      ),
    );
  }

  @override
  $CoffeeDetailPageDriverProvider get driverProvider => $CoffeeDetailPageDriverProvider();
}
