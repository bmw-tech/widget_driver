import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../../models/coffee.dart';
import '../../../../services/coffee_image_service.dart';

part 'coffee_detail_page_driver.g.dart';

@Driver()
class CoffeeDetailPageDriver extends WidgetDriver {
  CoffeeDetailPageDriver({
    CoffeeImageService? coffeeImageService,
  }) : _coffeeImageService = coffeeImageService ?? GetIt.I.get<CoffeeImageService>();

  final CoffeeImageService _coffeeImageService;

  @DriverProperty("https://coffee.uaerman.dev/random")
  String get coffeeImageUrl {
    return _coffeeImageService.getImageUrlForCoffee(Coffee());
  }
}
