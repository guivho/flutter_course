import 'package:flutter/material.dart';
import './tabs/product_edit_tab.dart';
import './tabs/product_list_tab.dart';
import '../utils/constants.dart';
import './../widgets/ui_elements/left_drawer.dart';
import '../models/product.dart';

class ProductsAdminPage extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;
  final Function updateProduct;

  final List<Product> products;

  ProductsAdminPage(
      this.addProduct, this.updateProduct, this.deleteProduct, this.products);

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
        ProductEditTab(addProduct: addProduct),
        ProductListTab(products, updateProduct, deleteProduct),
      ],
    );
  }
}
