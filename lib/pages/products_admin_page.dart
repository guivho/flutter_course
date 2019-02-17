import 'package:flutter/material.dart';
import './product_create_tab.dart';
import './product_list_tab.dart';
import '../utils/constants.dart';

class ProductsAdminPage extends StatelessWidget {
  final Function _addProduct;
  final Function _deleteProduct;

  ProductsAdminPage(this._addProduct, this._deleteProduct);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: buildScaffold(context),
    );
  }

  Widget buildScaffold(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Text('Products Admin'),
        bottom: buildTabBar(),
      ),
      body: buildTabBarView(),
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      tabs: <Widget>[
        Tab(icon: Icon(Icons.create), text: 'Create Product'),
        Tab(icon: Icon(Icons.list), text: 'My Products'),
      ],
    );
  }

  TabBarView buildTabBarView() {
    return TabBarView(
      children: <Widget>[
        ProductCreateTab(_addProduct),
        ProductListTab(),
      ],
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
        Navigator.pushReplacementNamed(context, PRODUCTSROUTE);
      },
    );
  }
}
