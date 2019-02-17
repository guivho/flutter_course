import 'package:flutter/material.dart';
import './product_list.dart';
import './product_control.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, String>> _products;
  final Function _addProduct;
  final Function _deleteProduct;

  ProductManager(this._products, this._addProduct, this._deleteProduct);

  @override
  Widget build(BuildContext context) {
    print('[ProductManager State] build()');
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(_addProduct),
        ),
        Expanded(
          child: ProductList(_products, deleteProduct: _deleteProduct),
        ),
      ],
    );
  }
}
