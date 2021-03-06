import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit_tab.dart';
import '../../models/product.dart';
import '../../scoped-models/main_model.dart';
import '../../utils/util.dart';
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
    widget.model.fetchProducts().then((bool ok) {
      if (!ok) Util.showTryAgainDialog(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = model.isLoading
            ? Spinner()
            : model.myProducts.length <= 0
                ? NoProducts()
                : ListView.builder(
                    itemCount: model.myProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildDismissible(model, model.myProducts[index]);
                    },
                  );
        return RefreshIndicator(
          child: content,
          onRefresh: model.fetchProducts,
        );
      },
    );
  }

  Widget _buildDismissible(MainModel model, Product product) {
    return Dismissible(
      key: Key(product.productId),
      background: Container(color: Colors.red),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          model.deleteProduct(product.productId).then((bool ok) {
            if (!ok) Util.showTryAgainDialog(context);
          });
        }
      },
      child: _buildPoductTile(model, product),
    );
  }

  Widget _buildPoductTile(MainModel model, Product product) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.imageUrl),
          ),
          title: Text(product.title),
          subtitle: Text('€${product.price.toString()}'),
          trailing: _buildEditButton(context, product, model),
        ),
        Divider(),
      ],
    );
  }

  Widget _buildEditButton(
      BuildContext context, Product product, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditTab(product, model.user);
            },
          ),
        )
            // .then((_) => model.selectProduct(null))
            ;
      },
    );
  }
}
