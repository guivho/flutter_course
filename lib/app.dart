import 'package:flutter/material.dart';
import './utils/constants.dart';
// import 'package:flutter/rendering.dart';
import './pages/products_admin_page.dart';
import './pages/products_page.dart';
import './pages/product_page.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  final List<Map<String, String>> _products = [];

  @override
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
      // home: AuthPage(), (conflict with route '/')
      routes: defineRoutes(context, _products, _addProduct, _deleteProduct),
      onGenerateRoute: (RouteSettings settings) {
        return defineOnGenerateRoute(context, settings);
      },
      onUnknownRoute: (RouteSettings settings) {
        print('CAVE: unknown route ${settings.name}');
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                ProductsPage(_products, _addProduct, _deleteProduct));
      },
    );
  }

  void _addProduct(Map<String, String> product) {
    setState(() {
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
              _products[index][PRODUCTSTITLE],
              _products[index][PRODUCTSIMAGEURL],
            ),
      );
    }
    return null;
  }

  Map<String, WidgetBuilder> defineRoutes(
      BuildContext context,
      List<Map<String, String>> products,
      Function addProduct,
      Function deleteProduct) {
    return {
      ADMINROUTE: (BuildContext context) => ProductsAdminPage(),
      PRODUCTSROUTE: (BuildContext context) =>
          ProductsPage(products, addProduct, deleteProduct),
    };
  }
}
