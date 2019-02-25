import 'package:flutter/material.dart';
import './product_edit_tab.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped-models/products_model.dart';

class ProductListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return ListView.builder(
          itemCount: model.products.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.products[index].id),
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
                          AssetImage(model.products[index].imageUrl),
                    ),
                    title: Text(model.products[index].title),
                    subtitle:
                        Text('€${model.products[index].price.toString()}'),
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

  Widget _buildEditButton(
      BuildContext context, int index, ProductsModel model) {
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
