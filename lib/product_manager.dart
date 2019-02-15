import 'package:flutter/material.dart';
import './products.dart';

class ProductManager extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }

  final List<String> products;
  ProductManager(this.products);
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];

  @override
  void initState() {
    super.initState();
    _products = widget.products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                _products.add('Tester ${_products.length + 1}');
              });
            },
            child: Text('Add Product'),
          ),
        ),
        Products(_products),
      ],
    );
  }
}
