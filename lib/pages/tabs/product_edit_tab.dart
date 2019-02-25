import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../models/product.dart';

class ProductEditTab extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product product;
  final int productIndex;

  ProductEditTab(
      {this.product, this.addProduct, this.updateProduct, this.productIndex});

  @override
  _ProductEditTabState createState() => new _ProductEditTabState();
}

class _ProductEditTabState extends State<ProductEditTab> {
  final Product _formData = Product();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return widget.product == null
        ? _buildMainBody() //adding
        // editing
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit product'),
            ),
            body: _buildMainBody(),
          );
  }

  GestureDetector _buildMainBody() {
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

  RaisedButton _buildSubmitButton() {
    return RaisedButton(
      child: Text('Save'),
      onPressed: _submitForm,
    );
  }

  void _submitForm() {
    // alternative to autovalidate
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (widget.product != null) {
        _formData.id = widget.product.id;
      }
      if (widget.product == null) {
        widget.addProduct(_formData);
      } else {
        widget.updateProduct(widget.productIndex, _formData);
      }
      Navigator.pushReplacementNamed(context, PRODUCTSROUTE);
    }
  }

  _buildTitleField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title:'),
      initialValue: widget.product == null ? '' : widget.product.title,
      validator: (String value) {
        if (value.isEmpty) return 'Please supply a title';
        if (value.length < 5) return 'Title must be 5 characters or more';
      },
      onSaved: (String value) {
        _formData.title = value;
      },
    );
  }

  _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Description:'),
      maxLines: 4,
      maxLength: 256,
      initialValue: widget.product == null ? '' : widget.product.description,
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

  _buildPriceField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price:'),
      keyboardType: TextInputType.number,
      initialValue:
          widget.product == null ? '' : widget.product.price.toString(),
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
