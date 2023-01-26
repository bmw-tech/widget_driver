import 'package:widget_driver/widget_driver.dart';

import '../../../../models/coffee.dart';

part 'coffee_detail_page_driver.g.dart';

@GenerateTestDriver()
class CoffeeDetailPageDriver extends WidgetDriver {
  final Coffee _coffee;

  CoffeeDetailPageDriver(
    BuildContext context, {
    @driverProvidableModel required Coffee coffee,
  })  : _coffee = coffee,
        super(context);

  @TestDriverDefaultValue(TestCoffee.testCoffeeName)
  String get coffeeName {
    return _coffee.name;
  }

  @TestDriverDefaultValue(TestCoffee.testCoffeeDescription)
  String get coffeeDescription {
    return _coffee.description;
  }

  @TestDriverDefaultValue(TestCoffee.testCoffeeImageUrl)
  String get coffeeImageUrl {
    return _coffee.imageUrl;
  }
}
