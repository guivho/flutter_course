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
  int _selectedProductIndex;
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

  void fetchProducts() {
    _isLoading = true;
    notifyListeners();
    print('[model] fetchProducts');
    final List<Product> fetchedProductList = [];
    http.get(PRODUCTSURL).then((http.Response response) {
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

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[selectedProductIndex];
  }

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

  bool isFavorite(int index) {
    if (index >= 0 && index < _products.length) {
      return _products[index].isFavorite;
    }
    return null;
  }

  void toggleFavorite(int index) {
    if (index >= 0 && index < _products.length) {
      _products[index] = Product.favoriteToggled(_products[index]);
      notifyListeners();
    }
  }

  void selectProduct(int index) {
    if (index == null || (index >= 0 && index < _products.length)) {
      _selectedProductIndex = index;
      if (index != null) {
        notifyListeners();
      }
    }
  }

  void updateProduct(FormData formData) {
    _isLoading = true;
    _products[_selectedProductIndex] =
        Product.fromForm(_products[_selectedProductIndex].productId, formData);
    _isLoading = false;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
    notifyListeners();
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
