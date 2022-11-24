class CoffeeImageService {
  final String _randomCoffeeUrl = 'https://coffee.alexflipnote.dev/random';

  String getRandomCoffeeImageUrl() {
    return '$_randomCoffeeUrl?${DateTime.now()}';
  }
}
