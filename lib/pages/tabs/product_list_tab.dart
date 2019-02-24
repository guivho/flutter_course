import 'package:flutter/material.dart';
import '../../models/product.dart';
import './product_edit_tab.dart';

class ProductListTab extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListTab(this.products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(products[index].id.toString()),
          background: Container(color: Colors.red),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              deleteProduct(products[index]);
            }
          },
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(products[index].imageUrl),
                ),
                title: Text(products[index].title),
                subtitle: Text('€${products[index].price.toString()}'),
                trailing: _buildEditButton(context, products[index]),
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }

  IconButton _buildEditButton(BuildContext context, Product product) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditTab(
                product: product,
                updateProduct: updateProduct,
              );
            },
          ),
        );
      },
    );
  }
}
