import 'package:get_it/get_it.dart';

import 'api_client/api_client.dart';
import 'services/services.dart';

class DependencyInjectionManager {
  static void setup() {
    GetIt.I.registerLazySingleton<CoffeeConsumptionService>(() => CoffeeConsumptionService());
    GetIt.I.registerLazySingleton<CoffeeImageService>(() => CoffeeImageService());
    GetIt.I.registerLazySingleton<CoffeeService>(() => CoffeeService());
    GetIt.I.registerLazySingleton<ApiClient>(() => ApiClient());
  }
}
