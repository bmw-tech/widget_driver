import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';
import '../../../services/coffee_image_service.dart';

part 'random_coffee_image_widget_driver.g.dart';

@GenerateTestDriver()
class RandomCoffeeImageWidgetDriver extends WidgetDriver {
  final CoffeeImageService _coffeeImageService;
  late Localization _localization;

  RandomCoffeeImageWidgetDriver({
    CoffeeImageService? coffeeImageService,
  }) : _coffeeImageService = coffeeImageService ?? GetIt.I.get<CoffeeImageService>();

  @override
  void didUpdateBuildContext(BuildContext context) {
    _localization = context.read<Localization>();
  }

  String get coffeeImageUrl {
    return _coffeeImageService.getRandomCoffeeImageUrl();
  }

  String get title => _localization.randomCoffeeImageTitle;

  void updateRandomImage() {
    notifyWidget();
  }
}
