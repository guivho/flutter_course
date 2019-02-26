import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';

import '../models/product.dart';
import '../models/user.dart';
import '../utils/constants.dart';

mixin ConnectedProductsModel on Model {
  final List<Product> _products = [];
  User _authenticatedUser;
  int _selectedProductIndex;
  bool _showFavoritesOnly = false;

  Product userProduct(Product product) {
    return Product(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      location: product.location,
      isFavorite: product.isFavorite,
      userEmail: product.userEmail == null || product.userEmail == ''
          ? _authenticatedUser.email
          : product.userEmail,
      userId: product.userId == null || product.userId == ''
          ? _authenticatedUser.id
          : product.userId,
    );
  }

  void addProduct(Product product) {
    final Map<String, dynamic> productData = {
      'title': product.title,
      'description': product.description,
      'imageUrl':
          'https://cdn.pixabay.com/photo/2013/09/18/18/24/chocolate-183543_1280.jpg',
      'price': product.price,
    };
    http.post('$DBSERVER$PRODUCTS$JSON', body: json.encode(productData));
    _products.add(userProduct(product));
    notifyListeners();
  }
}

mixin ProductsModel on ConnectedProductsModel {
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
    if (_showFavoritesOnly) {
      return List.from(_products.where((p) => p.isFavorite == true));
    }
    return _products;
  }

  bool isFavorite(int index) {
    if (index >= 0 && index < _products.length) {
      return _products[index].isFavorite;
    }
    return null;
  }

  void toggleFavorite(int index) {
    if (index >= 0 && index < _products.length) {
      _selectedProductIndex = index;
      updateProduct(_products[_selectedProductIndex].toggleFavorite());
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

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
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
      id: Uuid().v1(),
      email: email,
      password: password,
    );
  }
}
