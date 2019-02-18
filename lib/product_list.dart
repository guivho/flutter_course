import 'package:flutter/material.dart';
import './utils/constants.dart';

class ProductList extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  // final Function(int) deleteProduct;

  ProductList(this.products) {
    print('[Producs Widget] Constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index][PRODUCTSIMAGEURL]),
          buildTitleAndPriceRow(context, products[index]),
          buildLocation(context),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              buildDetailsButton(context, index),
            ],
          ),
        ],
      ),
    );
  }

  buildLocation(BuildContext context) {
    return DecoratedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 25.0,
        ),
        child: Text('Union Square, San Francisco'),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Theme.of(context).primaryColorLight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
    );
  }

  Padding buildTitleAndPriceRow(context, Map<String, dynamic> product) {
    return Padding(
      // alternate for Container
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            product[PRODUCTSTITLE],
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
            ),
          ),
          SizedBox(width: 15.0),
          buildPrice(context, product[PRODUCTSPRICE]),
        ],
      ),
    );
  }

  DecoratedBox buildPrice(BuildContext context, double price) {
    return DecoratedBox(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Text('€${price.toString()}'),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Theme.of(context).primaryColorLight,
      ),
    );
  }

  FlatButton buildDetailsButton(BuildContext context, int index) {
    return FlatButton(
      child: Text('Details'),
      onPressed: () => Navigator.pushNamed<bool>(
            context,
            '$PRODUCTROUTE/$index',
          ).then((bool doDelete) {
            // if (doDelete) deleteProduct(index);
          }),
    );
  }

  Widget _buildProductList() {
    if (products.length == 0) {
      // return Center(
      //   child: Text("No products foud, please add some"),
      // );
      return Container();
    }
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: products.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] Build');
    return _buildProductList();
  }
}
