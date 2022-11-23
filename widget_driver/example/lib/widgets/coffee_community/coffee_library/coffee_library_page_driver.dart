import 'package:example/models/coffee.dart';
import 'package:widget_driver/widget_driver.dart';

part 'coffee_library_page_driver.g.dart';

@Driver()
class CoffeeLibraryPageDriver extends WidgetDriver {
  @DriverProperty(10)
  int get numberOfCoffees => 10;

  @DriverAction(_testCoffee)
  Coffee getCoffeeAtIndex(int index) {
    return const Coffee();
  }
}

const Coffee _testCoffee = Coffee();
