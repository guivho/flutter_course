import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './product_card.dart';
import '../../scoped-models/products_model.dart';
import '../../utils/constants.dart';
import '../../models/product.dart';

class ProductListWidget extends StatelessWidget {
  ProductListWidget() {
    print('[product_list_widget] Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('[product_list_widget] Build');
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return _buildProductList(model.products);
    });
  }

  Widget _buildProductList(List<Product> products) {
    if (products.length == 0) {
      return Container();
    }
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int productIndex) => ProductCard(
            product: products[productIndex],
            index: productIndex,
            cardType: CardType.list,
          ),
    );
  }
}
