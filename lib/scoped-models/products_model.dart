import './connected_products_model.dart';

import '../models/product.dart';

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavoritesOnly = false;

  List<Product> get allProducts {
    // copy the list and return the copy, not the original
    // to garantee immutability
    return List.from(products);
  }

  List<Product> get displayedProducts {
    // copy the list and return the copy, not the original
    // to garantee immutability
    if (_showFavoritesOnly) {
      return List.from(products.where((p) => p.isFavorite == true));
    }
    return allProducts;
  }

  int get selectedProductIndex {
    return currentSelectedProductIndex;
  }

  bool get showFavoriteOnly {
    return _showFavoritesOnly;
  }

  Product get selectedProduct {
    if (currentSelectedProductIndex == null) {
      return null;
    }
    return products[selectedProductIndex];
  }

  bool isfavorite(int index) {
    if (index >= 0 && index < products.length) {
      return products[index].isFavorite;
    }
    return null;
  }

  void updateProduct(Product product) {
    products[selectedProductIndex] = product;
    currentSelectedProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(selectedProductIndex);
    currentSelectedProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    if (index >= 0 && index < products.length) {
      currentSelectedProductIndex = index;
    }
  }

  void toggleFavorite(int index) {
    if (index >= 0 && index < products.length) {
      currentSelectedProductIndex = index;
      updateProduct(products[selectedProductIndex].toggleFavorite());
      notifyListeners();
    }
  }

  void toggleShowFavorites() {
    _showFavoritesOnly = !_showFavoritesOnly;
    notifyListeners();
  }
}
