import 'package:flutter/material.dart';
import './products_page.dart';

class ProductsAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Text('Products Admin'),
      ),
      body: Center(
        child: Text('To be developed'),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
              automaticallyImplyLeading: false, // no hamburger here!
              title: Text('Choose')),
          buildManageProductsPageTile(context),
        ],
      ),
    );
  }

  ListTile buildManageProductsPageTile(BuildContext context) {
    return ListTile(
      title: Text('Products'),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => ProductsPage()),
        );
      },
    );
  }
}
