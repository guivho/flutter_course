import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final bool displayOnly;
  final Product product;

  ProductItem(this.product, this.displayOnly);

  @override
  Widget build(BuildContext context) {
    return _buildProductItem(context);
  }

  Widget _buildProductItem(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.imageUrl),
          _buildTitleAndPriceRow(context),
          _buildLocation(context),
          _buildButtonBar(context),
          _buildDescription(context),
        ],
      ),
    );
  }

  Container _buildDescription(BuildContext context) {
    if (displayOnly) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(product.description),
    );
  }

  ButtonBar _buildButtonBar(BuildContext context) {
    Widget _detailsOrDelete = displayOnly
        ? _buildDetailsButton(context)
        : _buildDeleteButton(context);
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        _detailsOrDelete,
        _buildFavoriteButton(context),
      ],
    );
  }

  DecoratedBox _buildLocation(BuildContext context) {
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

  Padding _buildTitleAndPriceRow(context) {
    return Padding(
      // alternate for Container
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            product.title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Oswald',
            ),
          ),
          SizedBox(width: 15.0),
          _buildPrice(context),
        ],
      ),
    );
  }

  DecoratedBox _buildPrice(BuildContext context) {
    return DecoratedBox(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Text('€${product.price.toString()}'),
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

  IconButton _buildFavoriteButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite_border),
      color: Theme.of(context).primaryColor,
      iconSize: 30.0,
      onPressed: () => {},
    );
  }

  IconButton _buildDetailsButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info),
      iconSize: 30.0,
      color: Theme.of(context).primaryColor,
      onPressed: () => Navigator.pushNamed<bool>(
            context,
            '$PRODUCTROUTE/${product.id}',
          ).then((bool doDelete) {
            // if (doDelete) deleteProduct(index);
          }),
    );
  }

  IconButton _buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      iconSize: 30.0,
      color: Theme.of(context).primaryColor,
      onPressed: () => _showWarningDialog(context),
    );
  }

  _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure?"),
          content: Text('This action can not be undone!'),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context); // dismiss the dialog
              },
            ),
            FlatButton(
              child: Text('DO DELETE'),
              onPressed: () {
                Navigator.pop(context); // dismiss the dialog
                Navigator.pop(context, true); // go back to delete
              },
            ),
          ],
        );
      },
    );
  }
}
