import 'package:widget_driver/widget_driver.dart';

import '../../../../models/coffee.dart';

part 'coffee_detail_page_driver.g.dart';

@GenerateTestDriver()
class CoffeeDetailPageDriver extends WidgetDriver {
  final int index;
  final Coffee _coffee;

  CoffeeDetailPageDriver(
    BuildContext context,
    @driverProvidableProperty this.index, {
    @driverProvidableProperty required Coffee coffee,
  })  : _coffee = coffee,
        super(context);

  @TestDriverDefaultValue(TestCoffee.testCoffeeName)
  String get coffeeName {
    return '$index. ${_coffee.name}';
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
