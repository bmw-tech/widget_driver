import 'package:example/widgets/coffee_community/coffee_library/coffee_detail/coffee_detail_page.dart';
import 'package:flutter/material.dart';

import '../../../models/coffee.dart';

class CoffeeRow extends StatelessWidget {
  final Coffee coffee;

  const CoffeeRow({Key? key, required this.coffee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoffeeDetailPage()),
        );
      },
      child: Container(
        height: 50,
        color: Colors.teal,
        child: Center(child: Text(coffee.name)),
      ),
    );
  }
}
