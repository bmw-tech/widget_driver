import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/coffee.dart';

class CoffeeService {
  List<Coffee> _coffeeList = [];
  final _isFetchingStreamController = StreamController<bool>.broadcast()
    ..add(false);

  Stream<bool> get isFetchingStream => _isFetchingStreamController.stream;

  Future<List<Coffee>> getAllCoffees() async {
    _isFetchingStreamController.add(true);
    try {
      final response = await http
          .get(Uri.parse('https://api.sampleapis.com/coffee/hot'))
          .timeout(
            const Duration(seconds: 5),
          );

      if (response.statusCode == 200) {
        Iterable iterable = json.decode(response.body);
        _coffeeList = List<Coffee>.from(
            iterable.map((itemJson) => Coffee.fromJson(itemJson)));
        _coffeeList.retainWhere((coffee) {
          // Only keep coffees with valid imageUrl
          final uri = Uri.parse(coffee.imageUrl);
          return uri.hasScheme;
        });
      } else {
        // ignore: avoid_print
        print('Failed to fetch coffees');
      }
    } catch (error) {
      // ignore: avoid_print
      print('Failed to fetch coffees with error: $error');
    }

    _isFetchingStreamController.add(false);
    return _coffeeList;
  }
}
