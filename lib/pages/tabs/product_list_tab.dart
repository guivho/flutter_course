import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit_tab.dart';
import '../../scoped-models/main_model.dart';
import '../../widgets/ui_elements/no_products.dart';
import '../../widgets/ui_elements/spinner.dart';

class ProductListTab extends StatefulWidget {
  final MainModel model;
  ProductListTab(this.model);

  @override
  _ProductListTabState createState() => new _ProductListTabState();
}

class _ProductListTabState extends State<ProductListTab> {
  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = model.isLoading
            ? Spinner()
            : model.allProducts.length <= 0
                ? NoProducts()
                : ListView.builder(
                    itemCount: model.allProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildDismissible(model, index);
                    },
                  );
        return RefreshIndicator(
          child: content,
          onRefresh: model.fetchProducts,
        );
      },
    );
  }

  Widget _buildDismissible(MainModel model, int index) {
    return Dismissible(
      key: Key(model.displayedProducts[index].productId),
      background: Container(color: Colors.red),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          model.selectProduct(index);
          model.deleteProduct();
        }
      },
      child: _buildPoductTile(model, index),
    );
  }

  Widget _buildPoductTile(MainModel model, int index) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage(model.displayedProducts[index].imageUrl),
          ),
          title: Text(model.displayedProducts[index].title),
          subtitle: Text('€${model.displayedProducts[index].price.toString()}'),
          trailing: _buildEditButton(context, index, model),
        ),
        Divider(),
      ],
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
        ).then((_) => model.selectProduct(null));
      },
    );
  }
}
