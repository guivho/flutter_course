import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './product_card.dart';
import '../../scoped-models/main_model.dart';
import '../../widgets/ui_elements/no_products.dart';
import '../../widgets/ui_elements/spinner.dart';
import '../../utils/constants.dart';
import '../../models/product.dart';

class ProductListWidget extends StatelessWidget {
  ProductListWidget() {
    print('[product_list_widget] Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('[product_list_widget] Build');
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, _, MainModel model) {
      if (model.isLoading) return Spinner();
      if (model.displayedProducts.length <= 0) return NoProducts();
      return model.isLoading
          ? Spinner()
          : _buildProductList(model.displayedProducts);
    });
  }

  Widget _buildProductList(List<Product> products) {
    if (products.length == 0) {
      return Container();
    }
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int productIndex) => ProductCard(
            product: products[productIndex],
            index: productIndex,
            cardType: CardType.list,
          ),
    );
  }
}
