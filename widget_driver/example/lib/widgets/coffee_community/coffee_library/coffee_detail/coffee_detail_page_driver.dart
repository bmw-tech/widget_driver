import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../../models/coffee.dart';

part 'coffee_detail_page_driver.g.dart';

@Driver()
class CoffeeDetailPageDriver extends WidgetDriver {
  final Coffee _coffee;

  CoffeeDetailPageDriver(BuildContext context)
      : _coffee = context.read<Coffee>(),
        super(context);

  @DriverProperty(TestCoffee.testCoffeeName)
  String get coffeeName {
    return _coffee.name;
  }

  @DriverProperty(TestCoffee.testCoffeeDescription)
  String get coffeeDescription {
    return _coffee.description;
  }

  @DriverProperty(TestCoffee.testCoffeeImageUrl)
  String get coffeeImageUrl {
    return _coffee.imageUrl;
  }
}
