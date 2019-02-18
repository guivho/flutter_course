import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/product.dart';

class ProductCreateTab extends StatefulWidget {
  final Function _addProduct;

  ProductCreateTab(this._addProduct);

  @override
  _ProductCreateTabState createState() => new _ProductCreateTabState();
}

class _ProductCreateTabState extends State<ProductCreateTab> {
  Product _product = Product();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          buildTitleField(),
          buildDescriptionField(),
          buildPriceField(),
          SizedBox(height: 10.0),
          buildSubmitButton(),
        ],
      ),
    );
  }

  buildSubmitButton() {
    return RaisedButton(
      child: Text('Save'),
      color: Theme.of(context).accentColor,
      onPressed: () {
        _product.imageUrl = 'assets/food.jpg';
        widget._addProduct(_product);
        Navigator.pushReplacementNamed(context, PRODUCTSROUTE);
      },
    );
  }

  buildTitleField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Title:'),
      onChanged: (String value) {
        setState(() {
          _product.title = value;
        });
      },
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Description:'),
      maxLines: 4,
      maxLength: 256,
      onChanged: (String value) {
        setState(() {
          _product.description = value;
        });
      },
    );
  }

  buildPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Price:'),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        setState(() {
          _product.price = double.parse(value);
        });
      },
    );
  }
}
