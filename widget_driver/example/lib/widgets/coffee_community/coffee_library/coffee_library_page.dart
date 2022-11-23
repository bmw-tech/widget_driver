import 'package:example/widgets/coffee_community/coffee_library/coffee_row.dart';
import 'package:flutter/material.dart';

import 'coffee_library_page_driver.dart';

class CoffeeLibraryPage extends $CoffeeLibraryPageDrivableWidget {
  CoffeeLibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: driver.numberOfCoffees,
        itemBuilder: (BuildContext context, int index) {
          final coffee = driver.getCoffeeAtIndex(index);
          return CoffeeRow(coffee: coffee);
        });
  }

  @override
  $CoffeeLibraryPageDriverProvider get driverProvider => $CoffeeLibraryPageDriverProvider();
}
