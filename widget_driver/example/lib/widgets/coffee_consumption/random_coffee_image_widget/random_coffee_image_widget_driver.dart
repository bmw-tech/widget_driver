import 'package:example/models/coffee.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';
import '../../../services/coffee_image_service.dart';

part 'random_coffee_image_widget_driver.g.dart';

@Driver()
class RandomCoffeeImageWidgetDriver extends WidgetDriver {
  final CoffeeImageService _coffeeImageService;
  final Localization _localization;

  RandomCoffeeImageWidgetDriver(
    BuildContext context, {
    CoffeeImageService? coffeeImageService,
  })  : _coffeeImageService = coffeeImageService ?? GetIt.I.get<CoffeeImageService>(),
        _localization = context.read<Localization>(),
        super(context);

  @DriverProperty(TestCoffee.testCoffeeImageUrl)
  String get coffeeImageUrl {
    return _coffeeImageService.getRandomCoffeeImageUrl();
  }

  @DriverProperty('Tap image to load a new one')
  String get title => _localization.randomCoffeeImageTitle;

  @DriverAction()
  void updateRandomImage() {
    notifyWidget();
  }
}
