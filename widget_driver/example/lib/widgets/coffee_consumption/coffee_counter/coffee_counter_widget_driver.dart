import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';
import '../../../services/coffee_consumption_service.dart';

part 'coffee_counter_widget_driver.g.dart';

@Driver()
class CoffeeCounterWidgetDriver extends WidgetDriver {
  final CoffeeConsumptionService _consumptionService;
  final Localization _localization;

  StreamSubscription? _subscription;

  CoffeeCounterWidgetDriver(
    BuildContext context, {
    CoffeeConsumptionService? consumptionService,
  })  : _consumptionService =
            consumptionService ?? GetIt.I.get<CoffeeConsumptionService>(),
        _localization = context.read<Localization>(),
        super(context) {
    _subscription = _consumptionService.counterStream.listen((event) {
      notifyWidget();
    });
  }

  @DriverProperty('Consumed coffees')
  String get descriptionText => _localization.consumedCoffees;

  @DriverProperty('3')
  String get amountText => '${_consumptionService.counter}';

  @DriverProperty('Consume coffee')
  String get consumeCoffeeButtonText => _localization.consumeCoffees;

  @DriverProperty('Reset consumption')
  String get resetCoffeeButtonText => _localization.resetConsumedCoffees;

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
