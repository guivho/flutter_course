import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/products/product_card.dart';
import '../utils/constants.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/products_model.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;

  ProductPage(this.productIndex);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("Back button pressed");
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
          final Product product = model.products[productIndex];
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title),
            ),
            body: ProductCard(product: product, cardType: CardType.info),
          );
        },
      ),
    );
  }
}
