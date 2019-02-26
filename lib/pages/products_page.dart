import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../utils/constants.dart';
import '../scoped-models/products_model.dart';
import '../widgets/products/product_list_widget.dart';
import '../widgets/ui_elements/left_drawer.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage() {
    print('products_page] Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('products_page] Build');
    return Scaffold(
      drawer: LeftDrawer(DrawerType.fromListToAdmin),
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          _buildShowFavoritesOnlyButton(),
        ],
      ),
      body: ProductListWidget(),
    );
  }

  Widget _buildShowFavoritesOnlyButton() {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return IconButton(
          icon: Icon(
              model.showFavoriteOnly ? Icons.favorite : Icons.favorite_border),
          onPressed: () => model.toggleShowFavorites(),
        );
      },
    );
  }
}
