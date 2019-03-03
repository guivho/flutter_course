import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped-models/main_model.dart';
import '../utils/constants.dart';
import '../widgets/products/product_card.dart';

class ProductPage extends StatelessWidget {
  final String productId;
  ProductPage(this.productId);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("Back button pressed");
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          final Product product = model.productWithId(productId);
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title),
            ),
            body: ProductCard(
              product: product,
              cardType: CardType.info,
              model: model,
            ),
          );
        },
      ),
    );
  }
}
