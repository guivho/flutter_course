import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../models/product.dart';

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
    final double mediaWidth = MediaQuery.of(context).size.width;
    final targetWidth = mediaWidth > 368.0 ? 368.0 : mediaWidth * 0.95;
    final targetPadding = (mediaWidth - targetWidth) / 2;
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: targetPadding),
        children: <Widget>[
          _buildTitleField(),
          _buildDescriptionField(),
          _buildPriceField(),
          SizedBox(height: 10.0),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  _buildSubmitButton() {
    return RaisedButton(
      child: Text('Save'),
      onPressed: _submitForm,
    );
  }

  void _submitForm() {
    _product.imageUrl = 'assets/food.jpg';
    _product.location = 'Union Square, San Francisco';
    widget._addProduct(_product);
    Navigator.pushReplacementNamed(context, PRODUCTSROUTE);
  }

  _buildTitleField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Title:'),
      onChanged: (String value) {
        setState(() {
          _product.title = value;
        });
      },
    );
  }

  _buildDescriptionField() {
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

  _buildPriceField() {
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
