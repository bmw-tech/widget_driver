import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';
import '../../../services/coffee_consumption_service.dart';

part 'coffee_counter_widget_driver.g.dart';

@Driver()
class CoffeeCounterWidgetDriver extends WidgetDriver {
  final CoffeeConsumptionService _consumptionService;

  StreamSubscription? _subscription;

  CoffeeCounterWidgetDriver({
    CoffeeConsumptionService? consumptionService,
  }) : _consumptionService = consumptionService ?? GetIt.I.get<CoffeeConsumptionService>() {
    _subscription = _consumptionService.counterStream.listen((event) {
      notifyWidget();
    });
  }

  @DriverProperty('Consumed coffees')
  final String descriptionText = Localization.consumedCoffees;

  @DriverProperty('3')
  String get amountText => '${_consumptionService.counter}';

  @DriverProperty('Consume coffee')
  final String consumeCoffeeButtonText = Localization.consumeCoffees;

  @DriverProperty('Reset consumption')
  final String resetCoffeeButtonText = Localization.resetConsumedCoffees;

  @DriverAction()
  void consumeCoffee() {
    _consumptionService.consumedOneCoffee();
  }

  @DriverAction()
  void resetConsumption() {
    _consumptionService.resetConsumption();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
