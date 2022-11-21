import 'dart:async';

/// An example service to handle coffee consumption
class CoffeeConsumptionService {
  int _counter = 0;
  final _counterStreamController = StreamController<int>.broadcast();

  int get counter => _counter;

  Stream<int> get counterStream => _counterStreamController.stream;

  void consumedOneCoffee() {
    _counter += 1;
    _counterStreamController.add(_counter);
  }

  void resetConsumption() {
    _counter = 0;
    _counterStreamController.add(_counter);
  }
}
