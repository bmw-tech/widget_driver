import 'package:example/widgets/coffee_community/coffee_library/coffee_row.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import 'coffee_library_page_driver.dart';

class CoffeeLibraryPage extends DrivableWidget<CoffeeLibraryPageDriver> {
  CoffeeLibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (driver.isFetching) {
      return const Center(
        child: SizedBox(
          width: 60.0,
          height: 60.0,
          child: CircularProgressIndicator(strokeWidth: 6),
        ),
      );
    } else {
      return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: driver.numberOfCoffees,
          itemBuilder: (BuildContext context, int index) {
            final coffee = driver.getCoffeeAtIndex(index);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CoffeeRow(
                index: index + 1,
                coffee: coffee,
              ),
            );
          });
    }
  }

  @override
  WidgetDriverProvider<CoffeeLibraryPageDriver> get driverProvider => $CoffeeLibraryPageDriverProvider();
}
