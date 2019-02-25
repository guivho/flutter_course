import 'package:flutter/material.dart';
import './product_card.dart';
import './../../models/product.dart';
import '../../utils/constants.dart';

class ProductListWidget extends StatelessWidget {
  final List<Product> products;
  // final Function(int) deleteProduct;

  ProductListWidget(this.products) {
    print('[product_list_widget] Constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return ProductCard(
        product: products[index], index: index, cardType: CardType.list);
  }

  @override
  Widget build(BuildContext context) {
    print('[product_list_widget] Build');
    if (products.length == 0) {
      return Container();
    }
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: products.length,
    );
  }
}
