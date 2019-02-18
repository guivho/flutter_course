import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductPage extends StatelessWidget {
  final Product _product;

  ProductPage(this._product);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("Back button pressed");
        Navigator.pop(context, false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_product.title),
        ),
        body: ProductItem(_product, false),
      ),
    );
  }
}
