import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './address_tag.dart';
import './price_tag.dart';
import '../ui_elements/title_default.dart';
import '../../models/card_type.dart';
import '../../models/product.dart';
import '../../scoped-models/main_model.dart';
import '../../utils/constants.dart';
import '../../utils/util.dart';

class ProductCard extends StatelessWidget {
  final CardType cardType;
  final Product product;
  final MainModel model;
  // final int index;

  ProductCard({this.product, this.cardType, this.model}) {
    print('[product_card] Constructor ${product.productId} ${product.title}');
  }

  @override
  Widget build(BuildContext context) {
    print('[product_card] Build ${product.productId} ${product.title}');
    return _buildProductItem(context);
  }

  Widget _buildProductItem(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _buildImage(product.imageUrl),
          _buildTitleAndPriceRow(context),
          AddressTag(product.location),
          _buildButtonBar(context),
          _buildUuid(),
          _buildDescription(),
          _buildUserEmail(),
          _buildUserId(),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return FadeInImage(
      image: NetworkImage(imageUrl),
      height: 300.0,
      fit: BoxFit.cover,
      placeholder: AssetImage('assets/food.jpg'),
    );
  }

  Container _buildUserEmail() {
    if (cardType == CardType.list) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(product.userEmail),
    );
  }

  Container _buildUserId() {
    if (cardType == CardType.list) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(product.userId),
    );
  }

  Container _buildUuid() {
    if (cardType == CardType.list) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(product.productId),
    );
  }

  Container _buildDescription() {
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
        : //_buildDeleteButton(context); // does not work
        Container();
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

  Widget _buildFavoriteButton(BuildContext context) {
    if (product == null) return null;
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return IconButton(
          icon: Icon(product.isFavoredBy(model.user.userId)
              ? Icons.favorite
              : Icons.favorite_border),
          color: Theme.of(context).primaryColor,
          iconSize: 30.0,
          onPressed: () {
            model.toggleFavorite(product.productId).then((bool ok) {
              if (!ok) Util.showTryAgainDialog(context);
            });
          },
        );
      },
    );
  }

  IconButton _buildInfoButton(BuildContext context) {
    if (product == null) return null;
    return IconButton(
      icon: Icon(Icons.info),
      iconSize: 30.0,
      color: Theme.of(context).primaryColor,
      onPressed: () => Navigator.pushNamed<bool>(
            context,
            '$PRODUCTROUTE/${product.productId}',
          ),
    );
  }

  // IconButton _buildDeleteButton(BuildContext context) {
  //   if (product == null) return null;
  //   return IconButton(
  //       icon: Icon(Icons.delete),
  //       iconSize: 30.0,
  //       color: Theme.of(context).primaryColor,
  //       onPressed: () {
  //         _showWarningDialog(context);
  //       });
  // }

//   _showWarningDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Are you sure?"),
//           content: Text('This action can not be undone!'),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('CANCEL'),
//               onPressed: () {
//                 Navigator.pop(context); // dismiss the dialog
//               },
//             ),
//             FlatButton(
//               child: Text('DO DELETE'),
//               onPressed: () {
//                 model.deleteProduct(product.productId).then((bool ok) {
//                   if (!ok) {
//                     Util.showErrorDialog(context);
//                     Navigator.pop(context); // dismiss the dialog
//                   } else {
//                     Navigator.pop(context); // dismiss the dialog
//                     Navigator.pop(context, true); // go back to list
//                   }
//                 });
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
}
