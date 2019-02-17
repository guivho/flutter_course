import 'package:flutter/material.dart';
import './utils/constants.dart';

class ProductControl extends StatelessWidget {
  final Function _addProduct;

  ProductControl(this._addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _addProduct({
          PRODUCTSTITLE: 'Sweets ${DateTime.now()}',
          PRODUCTSIMAGEURL: 'assets/food.jpg',
        });
      },
      child: Text('Add Product'),
    );
  }
}
