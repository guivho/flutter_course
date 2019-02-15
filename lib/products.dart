import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  Products([this.products = const []]) {
    print('[Producs Widget] Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('[Producs Widget] Build');
    return Column(
      children: products
          .map(
            (element) => Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/food.jpg',
                      ),
                      Text(element),
                    ],
                  ),
                ),
          )
          .toList(),
    );
  }
}
