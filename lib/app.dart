import 'package:flutter/material.dart';
import './utils/constants.dart';
// import 'package:flutter/rendering.dart';
import './pages/products_admin_page.dart';
import './pages/products_page.dart';
import './pages/product_page.dart';
import './pages/auth_page.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped-models/products_model.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  @override
  //final String _product = 'Food tester';
  Widget build(BuildContext context) {
    print('[app] build');
    return ScopedModel<ProductsModel>(
      // here we create the model that will be used
      // in the complete tree built by _buildMaterialApp
      model: ProductsModel(),
      child: _buildMaterialApp(),
    );
  }

  MaterialApp _buildMaterialApp() {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.red,
        buttonColor: Colors.deepOrange,

        // fontFamily: 'Oswald',
      ),
      // home: AuthPage(),
      routes: defineRoutes(context),
      onGenerateRoute: (RouteSettings settings) {
        return defineOnGenerateRoute(context, settings);
      },
      onUnknownRoute: (RouteSettings settings) {
        print('CAVE: unknown route ${settings.name}');
        return MaterialPageRoute(
            builder: (BuildContext context) => ProductsPage());
      },
    );
  }

  Route<dynamic> defineOnGenerateRoute(
      BuildContext context, RouteSettings settings) {
    final List<String> pathElements = settings.name.split('/');
    // valid paths must start with '/'
    if (pathElements[0] == '' && pathElements[1] == PRODUCT) {
      final int index = int.parse(pathElements[2]);
      return MaterialPageRoute<bool>(
        builder: (BuildContext context) => ProductPage(index),
      );
    }
    return null;
  }

  Map<String, WidgetBuilder> defineRoutes(BuildContext context) {
    return {
      ADMINROUTE: (BuildContext context) => ProductsAdminPage(),
      PRODUCTSROUTE: (BuildContext context) => ProductsPage(),
      AUTHROUTE: (BuildContext context) => AuthPage(),
    };
  }
}
