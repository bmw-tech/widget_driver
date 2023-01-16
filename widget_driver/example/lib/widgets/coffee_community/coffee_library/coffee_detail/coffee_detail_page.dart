import 'package:example/widgets/coffee_community/coffee_library/coffee_detail/coffee_detail_page_driver.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../custom_widgets/cached_network_image.dart';

class CoffeeDetailPage extends DrivableWidget<CoffeeDetailPageDriver> {
  CoffeeDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(driver.coffeeName),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Text(driver.coffeeDescription),
          ),
          CachedNetworkImage(imageUrl: driver.coffeeImageUrl)
        ],
      ),
    );
  }

  @override
  WidgetDriverProvider<CoffeeDetailPageDriver> get driverProvider =>
      $CoffeeDetailPageDriverProvider();
}
