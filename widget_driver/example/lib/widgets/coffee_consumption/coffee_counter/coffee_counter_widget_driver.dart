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
  late Localization _localization;

  StreamSubscription? _subscription;
  bool _isCurrentlyConsuming = false;

  CoffeeCounterWidgetDriver({
    CoffeeConsumptionService? consumptionService,
  }) : _consumptionService = consumptionService ?? GetIt.I.get<CoffeeConsumptionService>() {
    _subscription = _consumptionService.counterStream.listen((event) {
      notifyWidget();
    });
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    _localization = context.read<Localization>();
  }

  @TestDriverDefaultValue(3)
  int get coffeeCount => _consumptionService.counter;

  @TestDriverDefaultValue('Consume coffee quick')
  String get consumeCoffeeQuickButtonText => _localization.consumeCoffeeQuick;

  @TestDriverDefaultValue('Consume coffee slow')
  String get consumeCoffeeSlowButtonText =>
      _isCurrentlyConsuming ? _localization.consumingCoffee : _localization.consumeCoffeeSlow;

  @TestDriverDefaultValue('Reset consumption')
  String get resetCoffeeButtonText => _localization.resetConsumedCoffees;

  @TestDriverDefaultValue()
  void consumeCoffeeQuick() {
    _consumptionService.consumedOneCoffee();
  }

  /// Returns true if we could consume a coffee slow.
  /// We cannot consume slow if we are already consuming a slow coffee.
  @TestDriverDefaultFutureValue(false)
  Future<bool> consumeCoffeeSlow() async {
    if (_isCurrentlyConsuming) {
      return false;
    }
    _isCurrentlyConsuming = true;
    notifyWidget();

    await Future.delayed(const Duration(seconds: 2));
    _consumptionService.consumedOneCoffee();

    _isCurrentlyConsuming = false;
    notifyWidget();
    return true;
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
