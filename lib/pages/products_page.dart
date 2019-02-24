import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/product.dart';
import './../widgets/products/product_list_widget.dart';
import '../widgets/ui_elements/left_drawer.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products;

  ProductsPage(this.products) {
    print('products_page] Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('products_page] Build');
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
      body: ProductListWidget(products),
    );
  }
}
