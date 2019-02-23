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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    final targetWidth = mediaWidth > 368.0 ? 368.0 : mediaWidth * 0.95;
    final targetPadding = (mediaWidth - targetWidth) / 2;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          // see _submitForm
          // autovalidate: true,
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
        ),
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
    // alternative to autovalidate
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _product.imageUrl = 'assets/food.jpg';
      _product.location = 'Union Square, San Francisco';
      widget._addProduct(_product);
      Navigator.pushReplacementNamed(context, PRODUCTSROUTE);
    }
  }

  _buildTitleField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title:'),
      validator: (String value) {
        if (value.isEmpty) return 'Please supply a title';
        if (value.length < 5) return 'Title must be 5 characters or more';
      },
      onSaved: (String value) {
        _product.title = value;
      },
    );
  }

  _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Description:'),
      maxLines: 4,
      maxLength: 256,
      validator: (String value) {
        if (value.isEmpty) {
          if (value.isEmpty) return 'Please supply a title';
          if (value.length < 5) return 'Title must be 5 characters or more';
        }
      },
      onSaved: (String value) {
        _product.description = value;
      },
    );
  }

  _buildPriceField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price:'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) return 'Please provide a price';
        try {
          double.parse(value);
        } catch (error) {
          return 'Price must be a valid amount';
        }
      },
      onSaved: (String value) {
        _product.price = double.parse(value);
      },
    );
  }
}
