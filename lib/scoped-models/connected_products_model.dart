import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  final List<Product> products = [];
  User authenticatedUser;
  int currentSelectedProductIndex;

  void addProduct(Product product) {
    final Product newProduct = Product(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      location: product.location,
      isFavorite: product.isFavorite,
      userEmail: authenticatedUser.email,
      userId: authenticatedUser.id,
    );
    products.add(newProduct);
    currentSelectedProductIndex = null;
    notifyListeners();
  }
}
