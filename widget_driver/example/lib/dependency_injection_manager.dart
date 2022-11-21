import 'package:get_it/get_it.dart';

import 'services/coffee_consumption_service.dart';
import 'services/coffee_image_service.dart';

class DependencyInjectionManager {
  static void setup() {
    GetIt.I.registerLazySingleton<CoffeeConsumptionService>(() => CoffeeConsumptionService());
    GetIt.I.registerLazySingleton<CoffeeImageService>(() => CoffeeImageService());
  }
}
