import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/product.dart';
import './../widgets/products/product_list.dart';
import '../widgets/ui_elements/left_drawer.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> _products;

  ProductsPage(this._products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftDrawer(DrawerType.fromListToAdmin),
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
      ),
      body: ProductList(_products),
    );
  }
}
