import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Login'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, PRODUCTSROUTE);
          },
        ),
      ),
    );
  }
}
