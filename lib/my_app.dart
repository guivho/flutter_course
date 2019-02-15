import 'package:flutter/material.dart';
import './product_manager.dart';

class MyApp extends StatelessWidget {
  final String _product = 'Food tester';
  Widget build(BuildContext context) {
    print('[MyApp] build');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('EasyList'),
        ),
        body: ProductManager(startingProduct: _product),
      ),
    );
  }
}
