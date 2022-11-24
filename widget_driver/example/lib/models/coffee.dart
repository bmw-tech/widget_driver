class Coffee {
  final String name;
  final String description;
  final String imageUrl;

  const Coffee({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      name: json['title'],
      description: json['description'],
      imageUrl: json['image'],
    );
  }
}

/// Use this in your TestDrivers
class TestCoffee {
  static const testCoffeeImageUrl = 'https://coffee.alexflipnote.dev/random';

  static const testCoffee = Coffee(
    name: 'coffe',
    description: 'Some desc',
    imageUrl: testCoffeeImageUrl,
  );
}
