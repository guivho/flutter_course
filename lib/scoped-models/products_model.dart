import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductsModel extends Model {
  final List<Product> _products = [];

  int _selectedProductIndex;
  bool _showFavoritesOnly = false;

  List<Product> get products {
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
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  bool get showFavoriteOnly {
    return _showFavoritesOnly;
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }

  bool isfavorite(int index) {
    if (index >= 0 && index < _products.length) {
      return _products[index].isFavorite;
    }
    return null;
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    if (index >= 0 && index < _products.length) {
      _selectedProductIndex = index;
    }
  }

  void toggleFavorite(int index) {
    if (index >= 0 && index < _products.length) {
      _selectedProductIndex = index;
      updateProduct(_products[_selectedProductIndex].toggleFavorite());
      notifyListeners();
    }
  }

  void toggleShowFavorites() {
    _showFavoritesOnly = !_showFavoritesOnly;
    notifyListeners();
  }
}
