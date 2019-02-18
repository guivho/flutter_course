import 'package:flutter/material.dart';
import './utils/constants.dart';
// import 'package:flutter/rendering.dart';
import './pages/products_admin_page.dart';
import './pages/products_page.dart';
import './pages/product_page.dart';
import './pages/auth_page.dart';
import './models/product.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  final List<Product> _products = [];

  @override
  //final String _product = 'Food tester';
  Widget build(BuildContext context) {
    print('[MyApp] build');
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.red,
        // fontFamily: 'Oswald',
      ),
      // home: AuthPage(),
      routes: defineRoutes(context, _products, _addProduct, _deleteProduct),
      onGenerateRoute: (RouteSettings settings) {
        return defineOnGenerateRoute(context, settings);
      },
      onUnknownRoute: (RouteSettings settings) {
        print('CAVE: unknown route ${settings.name}');
        return MaterialPageRoute(
            builder: (BuildContext context) => ProductsPage(_products));
      },
    );
  }

  void _addProduct(Product product) {
    setState(() {
      product.id = _products.length;
      _products.add(product);
    });
    print(_products);
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  Route<dynamic> defineOnGenerateRoute(
      BuildContext context, RouteSettings settings) {
    final List<String> pathElements = settings.name.split('/');
    // valid paths must start with '/'
    if (pathElements[0] == '' && pathElements[1] == PRODUCT) {
      final int index = int.parse(pathElements[2]);
      return MaterialPageRoute<bool>(
        builder: (BuildContext context) => ProductPage(
              _products[index],
            ),
      );
    }
    return null;
  }

  Map<String, WidgetBuilder> defineRoutes(BuildContext context,
      List<Product> products, Function addProduct, Function deleteProduct) {
    return {
      ADMINROUTE: (BuildContext context) =>
          ProductsAdminPage(addProduct, deleteProduct),
      PRODUCTSROUTE: (BuildContext context) => ProductsPage(_products),
      AUTHROUTE: (BuildContext context) => AuthPage(),
    };
  }
}
