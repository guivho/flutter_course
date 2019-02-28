import 'package:flutter/material.dart';

import './form_data.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String location;
  final String imageUrl;
  final bool isFavorite;
  final String userEmail;
  final String userId;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.location,
      @required this.imageUrl,
      @required this.isFavorite,
      @required this.userEmail,
      @required this.userId});

  Product.favoriteToggled(Product productToToggle)
      : id = productToToggle.id,
        title = productToToggle.title,
        description = productToToggle.description,
        price = productToToggle.price,
        imageUrl = productToToggle.imageUrl,
        location = productToToggle.location,
        isFavorite = !productToToggle.isFavorite,
        userEmail = productToToggle.userEmail,
        userId = productToToggle.userId;

  Product.fromForm(String id, FormData formData)
      : id = id,
        title = formData.title,
        description = formData.description,
        price = formData.price,
        imageUrl = formData.imageUrl,
        location = formData.location,
        isFavorite = !formData.isFavorite,
        userEmail = formData.userEmail,
        userId = formData.userId;

  Product.fromJson(Map<String, dynamic> data)
      : id = data['name'],
        title = data['title'],
        description = data['description'],
        price = double.parse(data['price']),
        imageUrl = data['imageUrl'],
        location = data['location'],
        isFavorite = data['isFavorite'] == 1,
        userEmail = data['userEmail'],
        userId = data['userId'];
}
