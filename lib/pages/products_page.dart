import 'package:flutter/material.dart';
import './../product_manager.dart';
import './manage_products_page.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Text('EasyList'),
      ),
      body: ProductManager(),
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
      title: Text('Manage Products'),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ManageProductsPage()),
        );
      },
    );
  }
}
