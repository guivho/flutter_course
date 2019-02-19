import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/products/product_card.dart';
import '../utils/constants.dart';

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
        body: ProductCard(_product, CardType.info),
      ),
    );
  }
}
