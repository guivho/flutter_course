import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/products/product_card.dart';
import '../utils/constants.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("Back button pressed");
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: ProductCard(product: product, cardType: CardType.info),
      ),
    );
  }
}
