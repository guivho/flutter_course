import 'package:flutter/material.dart';
import './product_list.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, dynamic>> _products;

  ProductManager(this._products);

  @override
  Widget build(BuildContext context) {
    print('[ProductManager State] build()');
    return Column(
      children: <Widget>[
        Expanded(
          child: ProductList(_products),
        ),
      ],
    );
  }
}
