import 'package:example/widgets/coffee_community/coffee_library/coffee_detail/coffee_detail_page.dart';
import 'package:example/widgets/custom_widgets/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          MaterialPageRoute(
            builder: (context) => CoffeeDetailPage(
              coffee: coffee,
            ),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.brown.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CachedNetworkImage(imageUrl: coffee.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                coffee.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
