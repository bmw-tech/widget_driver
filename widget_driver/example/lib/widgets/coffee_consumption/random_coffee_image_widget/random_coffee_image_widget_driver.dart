import 'package:example/models/coffee.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';
import '../../../services/coffee_image_service.dart';

part 'random_coffee_image_widget_driver.g.dart';

@GenerateTestDriver()
class RandomCoffeeImageWidgetDriver extends WidgetDriver {
  final CoffeeImageService _coffeeImageService;
  final Locator _localizationLocator;

  RandomCoffeeImageWidgetDriver(
    BuildContext context, {
    CoffeeImageService? coffeeImageService,
  })  : _coffeeImageService = coffeeImageService ?? GetIt.I.get<CoffeeImageService>(),
        _localizationLocator = context.read,
        super(context);

  @TestDriverDefaultValue(TestCoffee.testCoffeeImageUrl)
  String get coffeeImageUrl {
    return _coffeeImageService.getRandomCoffeeImageUrl();
  }

  @TestDriverDefaultValue('Tap image to load a new one')
  String get title => _localizationLocator<Localization>().randomCoffeeImageTitle;

  @TestDriverDefaultValue()
  void updateRandomImage() {
    notifyWidget();
  }
}
