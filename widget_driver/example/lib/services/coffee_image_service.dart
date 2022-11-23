import '../models/coffee.dart';

class CoffeeImageService {
  final String _randomCoffeeUrl = "https://coffee.alexflipnote.dev/random";

  String getRandomCoffeeImageUrl() {
    return "$_randomCoffeeUrl?${DateTime.now()}";
  }

  String getImageUrlForCoffee(Coffee coffee) {
    return "$_randomCoffeeUrl?${coffee.name}";
  }
}
