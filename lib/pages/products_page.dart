import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main_model.dart';
import '../utils/constants.dart';
import '../widgets/products/product_list_widget.dart';
import '../widgets/ui_elements/left_drawer.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model) {
    print('[products_page] Constructor');
  }

  @override
  _ProductsPageState createState() => new _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('[products_page] Build');
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return IconButton(
          icon: Icon(
              model.showFavoriteOnly ? Icons.favorite : Icons.favorite_border),
          onPressed: () => model.toggleShowFavorites(),
        );
      },
    );
  }
}
