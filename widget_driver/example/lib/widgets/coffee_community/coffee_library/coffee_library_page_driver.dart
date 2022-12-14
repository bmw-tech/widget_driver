import 'dart:async';

import 'package:example/models/coffee.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../../services/coffee_service.dart';

part 'coffee_library_page_driver.g.dart';

@Driver()
class CoffeeLibraryPageDriver extends WidgetDriver {
  final CoffeeService _coffeeService;
  bool _isFetching = false;
  List<Coffee> _coffees = [];
  StreamSubscription? _subscription;

  CoffeeLibraryPageDriver(
    BuildContext context, {
    CoffeeService? coffeeService,
  })  : _coffeeService = coffeeService ?? GetIt.I.get<CoffeeService>(),
        super(context) {
    _subscription = _coffeeService.isFetchingStream.listen((isFetching) {
      _isFetching = isFetching;
      notifyWidget();
    });

    _getCoffees();
  }

  @DriverProperty(false)
  bool get isFetching => _isFetching;

  @DriverProperty(10)
  int get numberOfCoffees => _coffees.length;

  @DriverAction(TestCoffee.testCoffee)
  Coffee getCoffeeAtIndex(int index) {
    return _coffees[index];
  }

  Future<void> _getCoffees() async {
    _coffees = await _coffeeService.getAllCoffees();
    notifyWidget();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
