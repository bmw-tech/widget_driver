import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../localization/localization.dart';
import '../../../services/coffee_consumption_service.dart';

part 'coffee_counter_widget_driver.g.dart';

@GenerateTestDriver()
class CoffeeCounterWidgetDriver extends WidgetDriver {
  final CoffeeConsumptionService _consumptionService;
  final Localization _localization;

  StreamSubscription? _subscription;

  CoffeeCounterWidgetDriver(
    BuildContext context, {
    CoffeeConsumptionService? consumptionService,
  })  : _consumptionService = consumptionService ?? GetIt.I.get<CoffeeConsumptionService>(),
        _localization = context.read<Localization>(),
        super(context) {
    _subscription = _consumptionService.counterStream.listen((event) {
      notifyWidget();
    });
  }

  @TestDriverDefaultValue('Consumed coffees')
  String get descriptionText => _localization.consumedCoffees;

  @TestDriverDefaultValue('3')
  String get amountText => '${_consumptionService.counter}';

  @TestDriverDefaultValue('Consume coffee')
  String get consumeCoffeeButtonText => _localization.consumeCoffees;

  @TestDriverDefaultValue('Reset consumption')
  String get resetCoffeeButtonText => _localization.resetConsumedCoffees;

  @TestDriverDefaultValue()
  void consumeCoffee() {
    _consumptionService.consumedOneCoffee();
  }

  @TestDriverDefaultValue()
  void resetConsumption() {
    _consumptionService.resetConsumption();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
