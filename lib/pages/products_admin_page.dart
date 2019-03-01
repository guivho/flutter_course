import 'package:flutter/material.dart';
import './tabs/product_edit_tab.dart';
import './tabs/product_list_tab.dart';
import '../scoped-models/main_model.dart';
import '../utils/constants.dart';
import '../widgets/ui_elements/left_drawer.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel model;

  ProductsAdminPage(this.model) {
    print('[ProductsAdminPage] constructor');
  }

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
        ProductEditTab(),
        ProductListTab(model),
      ],
    );
  }
}
