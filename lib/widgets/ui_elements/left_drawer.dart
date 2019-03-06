import 'package:flutter/material.dart';

import '../../models/drawer_type.dart';
import '../../scoped-models/main_model.dart';
import '../../utils/constants.dart';

class LeftDrawer extends StatelessWidget {
  final DrawerType drawerType;
  final MainModel model;
  LeftDrawer(this.drawerType, this.model);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
              automaticallyImplyLeading: false, // no hamburger here!
              title: Text('Choose')),
          _buildTile(context),
          Divider(),
          _buildLogoutTile(context),
        ],
      ),
    );
  }

  ListTile _buildTile(BuildContext context) {
    if (drawerType == DrawerType.fromAdminToList)
      return _buildListProductsPageTile(context);
    else //if (drawerType == DrawerType.fromListToAdmin)
      return _buildManageProductsPageTile(context);
  }

  ListTile _buildLogoutTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Logout ${model.user.email}'),
      onTap: () {
        model.logout();
        Navigator.of(context).pushReplacementNamed(AUTHROUTE);
      },
    );
  }

  ListTile _buildManageProductsPageTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.edit),
      title: Text('Products Admin'),
      onTap: () {
        // this instantiates the ProductsAdmin withe the
        // four parameters that are defined and initialised in app.dart
        Navigator.pushReplacementNamed(context, ADMINROUTE);
      },
    );
  }

  ListTile _buildListProductsPageTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.shop),
      title: Text('Products'),
      onTap: () {
        Navigator.pushReplacementNamed(context, AUTHROUTE);
      },
    );
  }
}
