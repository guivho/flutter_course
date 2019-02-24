import 'package:flutter/material.dart';
import '../../models/product.dart';
import './product_edit_tab.dart';

class ProductListTab extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;

  ProductListTab(this.products, this.updateProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Container(
            width: 40.0,
            child: Image.asset(products[index].imageUrl),
          ),
          title: Text(products[index].title),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProductEditTab(
                      product: products[index],
                      updateProduct: updateProduct,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
