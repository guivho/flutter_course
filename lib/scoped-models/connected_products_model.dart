import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';

import '../models/form_data.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../utils/constants.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  User _authenticatedUser;
  String _selectedProductId;
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
      // print('response.body: ${response.body}');
      print('response.body: ${response.body}');
      final Map<String, dynamic> jsonData = json.decode(response.body);
      print('jsonData: $jsonData');
      final Product newProduct = Product.fromJson(jsonData[NAME], productData);
      print('newProduct: $newProduct');
      _products.add(newProduct);
      print('_products: $_products');
      _isLoading = false;
      notifyListeners();
    });
  }

  // Future only returned to be able to use RefreshIndicator
  Future<Null> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    print('[model] fetchProducts');
    final List<Product> fetchedProductList = [];
    return http.get(PRODUCTSURL).then((http.Response response) {
      Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        _products = [];
      } else {
        productListData.forEach((String productId, dynamic productData) {
          fetchedProductList.add(Product.fromJson(productId, productData));
        });
        _products = fetchedProductList;
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

  // String get selectedProductId {
  //   return _selectedProductId;
  // }

  // Product get selectedProduct {
  //   if (_selectedProductId == null) {
  //     return null;
  //   }
  //   return _products.firstWhere((Product product) {
  //     return product.productId == _selectedProductId;
  //   });
  // }

  List<Product> get allProducts {
    // copy the list and return the copy, not the original
    // to garantee immutability
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    // copy the list and return the copy, not the original
    // to garantee immutability
    final List<Product> products = _showFavoritesOnly
        ? List.from(_products.where((p) => p.isFavorite == true))
        : List.from(_products);
    print('displayedProducts: $products');
    return products;
  }

  Product productWithId(String productId) {
    final int index = _products.indexWhere((Product product) {
      return product.productId == productId;
    });
    return index >= 0 ? _products[index] : null;
  }

  int get _selectedProductIndex {
    return _products.indexWhere((Product product) {
      return _selectedProductId == product.productId;
    });
  }

  bool isFavorite(int index) {
    if (index >= 0 && index < _products.length) {
      return _products[index].isFavorite;
    }
    return null;
  }

  void toggleFavorite(String productId) {
    selectProduct(productId);
    _products[_selectedProductIndex] =
        Product.favoriteToggled(_products[_selectedProductIndex]);
    _selectedProductId = null;
    notifyListeners();
  }

  void selectProduct(String productId) {
    _selectedProductId = productId;
  }

  void updateProduct(String productId, FormData formData) {
    _isLoading = true;
    notifyListeners();
    final Product product = Product.fromForm(productId, formData);
    final Map<String, dynamic> productData = product.toProductData();
    http
        .put('$DBSERVER$PRODUCTS/$_selectedProductId$JSON',
            body: json.encode(productData))
        .then((http.Response response) {
      _products[_selectedProductIndex] = product;
      _isLoading = false;
      notifyListeners();
    });
  }

  void deleteProduct() {
    _isLoading = true;
    notifyListeners();
    http
        .delete('$DBSERVER$PRODUCTS/$_selectedProductId$JSON')
        .then((http.Response response) {
      _products.removeAt(_selectedProductIndex);
      _selectedProductId = null;
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
