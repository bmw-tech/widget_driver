import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../services/coffee_image_service.dart';

part 'random_coffee_image_widget_driver.g.dart';

@Driver()
class RandomCoffeeImageWidgetDriver extends WidgetDriver {
  RandomCoffeeImageWidgetDriver({
    CoffeeImageService? coffeeImageService,
  }) : _coffeeImageService = coffeeImageService ?? GetIt.I.get<CoffeeImageService>();

  final CoffeeImageService _coffeeImageService;

  @DriverProperty("https://coffee.uaerman.dev/random")
  String get coffeeImageUrl {
    return _coffeeImageService.getCoffeeImageUrl();
  }

  @DriverAction()
  void updateRandomImage() {
    notifyWidget();
  }
}
