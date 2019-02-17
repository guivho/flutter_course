import 'package:flutter/material.dart';
import './../product_manager.dart';
import '../utils/constants.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, String>> _products;
  final Function _addProduct;
  final Function _deleteProduct;

  ProductsPage(this._products, this._addProduct, this._deleteProduct);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ProductManager(_products, _addProduct, _deleteProduct),
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
      title: Text('Products Admin'),
      onTap: () {
        Navigator.pushReplacementNamed(context, ADMINROUTE);
      },
    );
  }
}
