import 'package:flutter/material.dart';
import './../product_manager.dart';
import '../utils/constants.dart';
import '../models/product.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> _products;

  ProductsPage(this._products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
      ),
      body: ProductManager(_products),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
              automaticallyImplyLeading: false, // no hamburger here!
              title: Text('Choose')),
          buildManageProductsTile(context),
        ],
      ),
    );
  }

  ListTile buildManageProductsTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.edit),
      title: Text('Products Admin'),
      onTap: () {
        Navigator.pushReplacementNamed(context, ADMINROUTE);
      },
    );
  }
}
