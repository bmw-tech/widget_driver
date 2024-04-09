import 'package:widget_driver/widget_driver.dart';

import '../../../../models/coffee.dart';

part 'coffee_detail_page_driver.g.dart';

@GenerateTestDriver()
class CoffeeDetailPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  int _index;
  Coffee _coffee;

  CoffeeDetailPageDriver(
    @driverProvidableProperty this._index, {
    @driverProvidableProperty required Coffee coffee,
  }) : _coffee = coffee;

  String get coffeeName {
    return '$_index. ${_coffee.name}';
  }

  String get coffeeDescription {
    return _coffee.description;
  }

  String get coffeeImageUrl {
    return _coffee.imageUrl;
  }

  @override
  void didUpdateProvidedProperties({required int newIndex, required Coffee newCoffee}) {
    _index = newIndex;
    _coffee = newCoffee;
  }
}
