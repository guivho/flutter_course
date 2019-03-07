import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_mode.dart';
import '../models/fb_auth_data.dart';
import '../models/form_data.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../utils/constants.dart';

mixin ConnectedProductsModel on Model {
  final Map<String, Product> _products = {};
  User _user;
  bool _isLoading = false;
  String token;

  bool get isLoading {
    return _isLoading;
  }

  User get user {
    return _user;
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
        ? List.from(
            _products.values.where((Product p) => p.isFavoredBy(_user.userId)))
        : List.from(_products.values);
    print('displayedProducts: $products');
    return products;
  }

  List<Product> get myProducts {
    return List.from(
        _products.values.where((Product p) => p.userId == _user.userId));
  }

  Future<bool> addProduct(FormData formData) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData =
        formData.toJson(_user.email, _user.userId);
    print('productData: $productData');
    return http
        .post('$PRODUCTSURL?auth=${_user.token}',
            body: json.encode(productData))
        .then((http.Response response) {
      final bool ok = response.statusCode == 200 || response.statusCode == 201;
      if (ok) {
        print('response.body: ${response.body}');
        final Map<String, dynamic> jsonData = json.decode(response.body);
        print('jsonData: $jsonData');
        final Product newProduct =
            Product.fromJson(jsonData[NAME], productData, _user.userId);
        print('newProduct: $newProduct');
        _products[newProduct.productId] = newProduct;
        print('_products: $_products');
      } else {
        print('(addProduct) statusCode: ${response.statusCode}');
      }
      _isLoading = false;
      notifyListeners();
      return ok;
    }).catchError((error) {
      print('(addProduct) catchError: $error');
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  void _removeAllProducts() {
    // delete local copies before fetchng from server
    _products.removeWhere((String key, Product product) {
      return key != null;
    });
  }

  // Future only returned to be able to use RefreshIndicator
  // (Note this onw using aync and await rather than .then
  // both are equivalent)
  Future<bool> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    print('[model] fetchProducts');
    try {
      final String url = '$PRODUCTSURL?auth=${_user.token}';
      final http.Response response = await http.get(url);
      print('statuscode: ${response.statusCode} from url: $PRODUCTSURL');
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
          _products[productId] =
              Product.fromJson(productId, productData, _user.userId);
        });
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      print('(fetchProducts) catch error: $error');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Product productWithId(String productId) {
    if (_products.containsKey(productId)) {
      return _products[productId];
    }
    return null;
  }

  Future<bool> toggleWished(String productId) async {
    _isLoading = true;
    notifyListeners();
    // the isWished is never written to disk
    // only the Wishers/userid boolean
    print('will toggle wished for ${_products[productId]}');
    bool newWishedStatus = !_products[productId].isWished;
    String url =
        '$DBSERVER$PRODUCTS/$productId/$P_WISHERS/${_user.userId}$JSON';
    print('url:$url');
    print('newWishedStatus:$newWishedStatus');
    final String body = json.encode(true);
    print('json.encode(true) => $body');
    http.Response response;
    if (newWishedStatus) {
      //push userId to Wishers
      print('going to post new wisher');
      response =
          // await http.post('$url?auth=${_user.token}', body: json.encode(true));
          await http.put('$url?auth=${_user.token}', body: body);
    } else {
      //remove user id from wishers
      print('deleting old wisher');
      response = await http.delete('$url?auth=${_user.token}');
    }
    bool ok = response.statusCode == 200 || response.statusCode == 201;
    print('ok:$ok statusCode:${response.statusCode}');
    if (ok) {
      _products[productId].isWished = !_products[productId].isWished;
    }
    _isLoading = false;
    print('done toggle wished for ${_products[productId]}');
    notifyListeners();
    return ok;
  }

  Future<bool> toggleFavorite(String productId) async {
    _isLoading = true;
    notifyListeners();
    // optimistic update: update local copy before server update
    final Product product =
        _products[productId].toggleFavoriteFor(_user.userId);
    return _updateProduct(product);
  }

  Future<bool> updateProduct(String productId, FormData formData) {
    final Product product = Product.fromForm(productId, formData);
    return _updateProduct(product);
  }

  Future<bool> _updateProduct(Product product) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = product.toJson();
    final String url = '$DBSERVER$PRODUCTS/${product.productId}$JSON';
    return http
        .put('$url?auth=${_user.token}', body: json.encode(productData))
        .then((http.Response response) {
      print('(updateProduct) statusCode: ${response.statusCode} from $url');
      if (response.statusCode != 200 && response.statusCode != 201) {
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
        .delete('$DBSERVER$PRODUCTS/$productId$JSON?auth=${_user.token}')
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

mixin UserModel on ConnectedProductsModel {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  User get user {
    return _user;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> authenticate(
      AuthMode authMode, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData =
        FbAuthData(email, password).toMapStringDynamic();
    final String url =
        '${authMode == AuthMode.Login ? FB_LOGIN : FB_SIGNUP}$FB_APIKEY';
    final http.Response response =
        await http.post(url, body: json.encode(authData));
    bool isOk = true;
    String message = 'Authentication succeeded!';
    final Map<String, dynamic> responseData = json.decode(response.body);
    print("responseData: $responseData");
    if (response.statusCode == 200 && responseData.containsKey(FB_IDTOKEN)) {
      final dynamic userData = json.decode(response.body);
      _user = User.fromJson(userData);
      final int seconds = int.parse(userData[FB_EXPIRESIN]);
      _userSubject.add(true);
      setAuthTimeout(seconds);
      final DateTime now = DateTime.now();
      final DateTime expiryTime = now.add(Duration(seconds: seconds));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(FB_IDTOKEN, userData[FB_IDTOKEN]);
      prefs.setString(FB_EMAIL, userData[FB_EMAIL]);
      prefs.setString(FB_LOCALID, userData[FB_LOCALID]);
      prefs.setString(FB_EXPIRYTIME, expiryTime.toIso8601String());
      print('_authenticated_user: $_user');
    } else {
      isOk = false;
      if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
        message = 'Email not found!';
      } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
        message = 'Invalid password!';
      } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
        message = 'Email already exists!';
      } else {
        message = 'Something went wrong!';
      }
    }
    _isLoading = false;
    notifyListeners();
    return {FB_SUCCESS: isOk, 'message': message};
  }

  Future<bool> autoAuthenticate() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString(FB_IDTOKEN);
    bool ok = false;
    _user = null;
    if (token != null) {
      final DateTime expiryTime =
          DateTime.parse(_prefs.getString(FB_EXPIRYTIME));
      final DateTime now = DateTime.now();
      final int seconds = expiryTime.difference(now).inSeconds;
      if (seconds <= 0) {
        notifyListeners();
        return false;
      }
      setAuthTimeout(seconds);
      final email = _prefs.getString(FB_EMAIL);
      final userId = _prefs.getString(FB_LOCALID);
      _user = User(email: email, token: token, userId: userId);
      _userSubject.add(true);
      ok = true;
    }
    notifyListeners();
    return ok;
  }

  void logout() async {
    print('logout');
    _user = null;
    _authTimer.cancel();
    _userSubject.add(false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(FB_IDTOKEN);
    prefs.remove(FB_EMAIL);
    prefs.remove(FB_LOCALID);
    prefs.remove(FB_EXPIRYTIME);
  }

  void setAuthTimeout(int seconds) {
    _authTimer = Timer(Duration(seconds: seconds), logout);
  }
}
