import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../models/product.dart';
import './price_tag.dart';
import '../ui_elements/title_default.dart';
import './address_tag.dart';

class ProductCard extends StatelessWidget {
  final CardType cardType;
  final Product product;

  ProductCard(this.product, this.cardType);

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
          AddressTag(product.location),
          _buildButtonBar(context),
          _buildDescription(context),
        ],
      ),
    );
  }

  Container _buildDescription(BuildContext context) {
    if (cardType == CardType.list) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(product.description),
    );
  }

  ButtonBar _buildButtonBar(BuildContext context) {
    Widget _infoOrDeleteButton = cardType == CardType.list
        ? _buildInfoButton(context)
        : _buildDeleteButton(context);
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        _infoOrDeleteButton,
        _buildFavoriteButton(context),
      ],
    );
  }

  Padding _buildTitleAndPriceRow(context) {
    return Padding(
      // alternate for Container
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product.title),
          SizedBox(width: 15.0),
          PriceTag(product.price),
          // _buildPrice(context),
        ],
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

  IconButton _buildInfoButton(BuildContext context) {
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
