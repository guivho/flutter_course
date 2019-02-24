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
    return ProductCard(products[index], CardType.list);
  }

  Widget _buildProductList() {
    if (products.length == 0) {
      return Container();
    }
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: products.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('[product_list_widget] Build');
    return _buildProductList();
  }
}
