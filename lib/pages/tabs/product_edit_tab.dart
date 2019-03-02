import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/form_data.dart';
import '../../models/product.dart';
import '../../scoped-models/main_model.dart';
import '../../utils/constants.dart';

class ProductEditTab extends StatefulWidget {
  final Product product;

  ProductEditTab(this.product);

  @override
  _ProductEditTabState createState() => new _ProductEditTabState();
}

class _ProductEditTabState extends State<ProductEditTab> {
  final FormData _formData = FormData();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return widget.product == null
            ? _buildMainBody(model) //adding
            // editing
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit product'),
                ),
                body: _buildMainBody(model),
              );
      },
    );
  }

  GestureDetector _buildMainBody(MainModel model) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    final targetWidth = mediaWidth > 368.0 ? 368.0 : mediaWidth * 0.95;
    final targetPadding = (mediaWidth - targetWidth) / 2;
    // final Product product = model.selectedProduct;
    // if (product != null) _formData.id = product.id;
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
              _buildTitleField(widget.product),
              _buildDescriptionField(widget.product),
              _buildPriceField(widget.product),
              SizedBox(height: 10.0),
              _buildSubmitButton(model, widget.product),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(MainModel model, Product product) {
    return RaisedButton(
      child: Text('Save'),
      onPressed: () => _submitForm(model, product),
    );
  }

  void _submitForm(MainModel model, Product product) {
    // alternative to autovalidate
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // if (product != null) {
      //   _formData.id = product.id;
      // }
      if (product == null) {
        model.addProduct(_formData);
      } else {
        model.updateProduct(product.productId, _formData);
      }
      Navigator.pushReplacementNamed(context, PRODUCTSROUTE)
          // .then((_) => model.selectProduct(null))
          ;
    }
  }

  _buildTitleField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title:'),
      initialValue: product == null ? '' : product.title,
      validator: (String value) {
        if (value.isEmpty) return 'Please supply a title';
        if (value.length < 5) return 'Title must be 5 characters or more';
      },
      onSaved: (String value) {
        _formData.title = value;
      },
    );
  }

  _buildDescriptionField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Description:'),
      maxLines: 4,
      maxLength: 256,
      initialValue: product == null ? '' : product.description,
      validator: (String value) {
        if (value.isEmpty) {
          if (value.isEmpty) return 'Please supply a title';
          if (value.length < 5) return 'Title must be 5 characters or more';
        }
      },
      onSaved: (String value) {
        _formData.description = value;
      },
    );
  }

  _buildPriceField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price:'),
      keyboardType: TextInputType.number,
      initialValue: product == null ? '' : product.price.toString(),
      validator: (String value) {
        if (value.isEmpty) return 'Please provide a price';
        try {
          double.parse(value);
        } catch (error) {
          return 'Price must be a valid amount';
        }
      },
      onSaved: (String value) {
        _formData.price = double.parse(value);
      },
    );
  }
}
