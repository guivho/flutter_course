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

  Future<bool> addProduct(FormData formData) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = formData.toProductData(
        authenticatedUser.email, authenticatedUser.userId);
    return http
        .post(PRODUCTSURL, body: json.encode(productData))
        .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('(addProduct) statusCode: ${response.statusCode}');
        return false;
      }
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final Product newProduct = Product.fromJson(jsonData[NAME], productData);
      _products[newProduct.productId] = newProduct;
      _isLoading = false;
      notifyListeners();
      return true;
    });
  }

  void _removeAllProducts() {
    // delete local copies before fetchng from server
    _products.removeWhere((String key, Product product) {
      return key != null;
    });
  }

  // Future only returned to be able to use RefreshIndicator
  Future<bool> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    print('[model] fetchProducts');
    return http.get(PRODUCTSURL).then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('(fetchProducts) statusCode: ${response.statusCode}');
        _isLoading = false;
        notifyListeners();
        return false;
      }
      Map<String, dynamic> productListData = json.decode(response.body);
      _removeAllProducts();
      if (productListData != null) {
        productListData.forEach((String productId, dynamic productData) {
          _products[productId] = Product.fromJson(productId, productData);
        });
      }
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      print('(fetchProducts) catchError: $error');
      _isLoading = false;
      notifyListeners();
      return false;
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

  Future<bool> toggleFavorite(String productId) {
    return _updateProduct(Product.favoriteToggled(_products[productId]));
  }

  Future<bool> updateProduct(String productId, FormData formData) {
    final Product product = Product.fromForm(productId, formData);
    return _updateProduct(product);
  }

  Future<bool> _updateProduct(Product product) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = product.toProductData();
    return http
        .put('$DBSERVER$PRODUCTS/${product.productId}$JSON',
            body: json.encode(productData))
        .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('(updateProduct) statusCode: ${response.statusCode}');
        return false;
      }
      _products[product.productId] = product;
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      print('(_updateProduct) catchError: $error');
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> deleteProduct(String productId) {
    _isLoading = true;
    notifyListeners();
    return http
        .delete('$DBSERVER$PRODUCTS/$productId$JSON')
        .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('(deleteProduct) statusCode: ${response.statusCode}');
        return false;
      }
      _products.remove(productId);
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      print('(deleteProduct) catchError: $error');
      _isLoading = false;
      notifyListeners();
      return false;
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
