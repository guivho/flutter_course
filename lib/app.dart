import 'package:flutter/material.dart';
import './pages/auth_page.dart';
// import 'package:flutter/rendering.dart';

class App extends StatelessWidget {
  //final String _product = 'Food tester';
  Widget build(BuildContext context) {
    print('[MyApp] build');
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple,
      ),
      home: AuthPage(),
    );
  }
}
