import 'package:flutter/material.dart';
import './tabs/product_create_tab.dart';
import './tabs/product_list_tab.dart';
import '../utils/constants.dart';
import './../widgets/ui_elements/left_drawer.dart';

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
      drawer: LeftDrawer(DrawerType.fromAdminToList),
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
}
