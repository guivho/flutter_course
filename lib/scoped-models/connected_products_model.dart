import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';

import '../models/form_data.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../utils/constants.dart';

mixin ConnectedProductsModel on Model {
  final Map<String, Product> _products = {};
  User _authenticatedUser;
  bool _isLoading = false;

  void addProduct(FormData formData) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = formData.toProductData(
        authenticatedUser.email, authenticatedUser.userId);
    print('productData: $productData');
    http
        .post(PRODUCTSURL, body: json.encode(productData))
        .then((http.Response response) {
      print('response.body: ${response.body}');
      final Map<String, dynamic> jsonData = json.decode(response.body);
      print('jsonData: $jsonData');
      final Product newProduct = Product.fromJson(jsonData[NAME], productData);
      print('newProduct: $newProduct');
      _products[newProduct.productId] = newProduct;
      print('_products: $_products');
      _isLoading = false;
      notifyListeners();
    });
  }

  void _removeAllProducts() {
    _products.removeWhere((String key, Product product) {
      return key != null;
    });
  }

  // Future only returned to be able to use RefreshIndicator
  Future<Null> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    print('[model] fetchProducts');
    return http.get(PRODUCTSURL).then((http.Response response) {
      Map<String, dynamic> productListData = json.decode(response.body);
      _removeAllProducts();
      if (productListData != null) {
        productListData.forEach((String productId, dynamic productData) {
          _products[productId] = Product.fromJson(productId, productData);
        });
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  bool get isLoading {
    return _isLoading;
  }

  // Hack: restarting app looses _authenticatedUser
  User get authenticatedUser {
    return _authenticatedUser != null
        ? _authenticatedUser
        : User(
            userId: Uuid().v1(),
            email: 'unknown',
            password: 'not relevant',
          );
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavoritesOnly = false;
  bool get showFavoriteOnly {
    return _showFavoritesOnly;
  }

  List<Product> get allProducts {
    return List.from(_products.values);
  }

  List<Product> get displayedProducts {
    final List<Product> products = _showFavoritesOnly
        ? List.from(_products.values.where((p) => p.isFavorite == true))
        : List.from(_products.values);
    print('displayedProducts: $products');
    return products;
  }

  Product productWithId(String productId) {
    if (_products.containsKey(productId)) {
      return _products[productId];
    }
    return null;
  }

  void toggleFavorite(String productId) {
    _products[productId] = Product.favoriteToggled(_products[productId]);
    notifyListeners();
  }

  void updateProduct(String productId, FormData formData) {
    _isLoading = true;
    notifyListeners();
    final Product product = Product.fromForm(productId, formData);
    final Map<String, dynamic> productData = product.toProductData();
    http
        .put('$DBSERVER$PRODUCTS/$productId$JSON',
            body: json.encode(productData))
        .then((http.Response response) {
      _products[productId] = product;
      _isLoading = false;
      notifyListeners();
    });
  }

  void deleteProduct(String productId) {
    _isLoading = true;
    notifyListeners();
    http
        .delete('$DBSERVER$PRODUCTS/$productId$JSON')
        .then((http.Response response) {
      _products.remove(productId);
      _isLoading = false;
      notifyListeners();
    });
  }

  void toggleShowFavorites() {
    _showFavoritesOnly = !_showFavoritesOnly;
    notifyListeners();
  }
}

mixin UsersModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(
      userId: Uuid().v1(),
      email: email,
      password: password,
    );
  }
}
