import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';

import '../models/form_data.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../utils/constants.dart';

mixin ConnectedProductsModel on Model {
  final List<Product> _products = [];
  User _authenticatedUser;
  int _selectedProductIndex;
  bool _showFavoritesOnly = false;

  void addProduct(FormData formData) {
    final Map<String, dynamic> productData =
        formData.toProductData(_authenticatedUser.email, _authenticatedUser.id);
    http
        .post('$DBSERVER$PRODUCTS$JSON', body: json.encode(productData))
        .then((http.Response response) {
      final Product newProduct = Product.fromJson(json.decode(response.body));
      _products.add(newProduct);
      notifyListeners();
    });
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
      _products[_selectedProductIndex] =
          Product.favoriteToggled(_products[index]);
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
    _products[_selectedProductIndex] =
        Product.fromForm(_products[_selectedProductIndex].id, formData);
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
