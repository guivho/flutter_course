import 'package:uuid/uuid.dart';

import './connected_products_model.dart';

import '../models/user.dart';

mixin UsersModel on ConnectedProductsModel {
  void login(String email, String password) {
    authenticatedUser = User(
      id: Uuid().v1(),
      email: email,
      password: password,
    );
  }
}
