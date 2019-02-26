import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit_tab.dart';
import '../../scoped-models/main_model.dart';

class ProductListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemCount: model.displayedProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.displayedProducts[index].id),
              background: Container(color: Colors.red),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectProduct(index);
                  model.deleteProduct();
                }
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage(model.displayedProducts[index].imageUrl),
                    ),
                    title: Text(model.displayedProducts[index].title),
                    subtitle: Text(
                        '€${model.displayedProducts[index].price.toString()}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditTab();
            },
          ),
        );
      },
    );
  }
}
