import 'package:flutter/material.dart';
import './product_manager.dart';

class MyApp extends StatelessWidget {
  final List<String> _products = ['Food tester'];
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('EasyList'),
        ),
        body: ProductManager(_products),
      ),
    );
  }
}
