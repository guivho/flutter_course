import 'package:flutter/material.dart';
import './product_list.dart';
import './models/product.dart';

class ProductManager extends StatelessWidget {
  final List<Product> _products;

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
