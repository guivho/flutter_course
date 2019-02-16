import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function _addProduct;

  ProductControl(this._addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _addProduct({
          'title': 'Sweets ${DateTime.now()}',
          'imageUrl': 'assets/food.jpg',
        });
      },
      child: Text('Add Product'),
    );
  }
}
