class CoffeeImageService {
  final String _randomCoffeeUrl = "https://coffee.alexflipnote.dev/random";

  String getCoffeeImageUrl() {
    return "$_randomCoffeeUrl?${DateTime.now()}";
  }
}
