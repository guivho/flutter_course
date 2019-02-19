import 'package:flutter/material.dart';
import './product_card.dart';
import './../../models/product.dart';
import '../../utils/constants.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  // final Function(int) deleteProduct;

  ProductList(this.products) {
    print('[Producs Widget] Constructor');
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
    print('[Products Widget] Build');
    return _buildProductList();
  }
}
