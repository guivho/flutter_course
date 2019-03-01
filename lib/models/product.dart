import 'package:flutter/material.dart';

import './form_data.dart';

class Product {
  final String productId;
  final String title;
  final String description;
  final double price;
  final String location;
  final String imageUrl;
  final bool isFavorite;
  final String userEmail;
  final String userId;

  Product(
      {@required this.productId,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.location,
      @required this.imageUrl,
      @required this.isFavorite,
      @required this.userEmail,
      @required this.userId});

  Product.favoriteToggled(Product productToToggle)
      : productId = productToToggle.productId,
        title = productToToggle.title,
        description = productToToggle.description,
        price = productToToggle.price,
        imageUrl = productToToggle.imageUrl,
        location = productToToggle.location,
        isFavorite = !productToToggle.isFavorite,
        userEmail = productToToggle.userEmail,
        userId = productToToggle.userId;

  Product.fromForm(String productId, FormData formData)
      : productId = productId,
        title = formData.title,
        description = formData.description,
        price = formData.price,
        imageUrl = formData.imageUrl,
        location = formData.location,
        isFavorite = formData.isFavorite,
        userEmail = formData.userEmail,
        userId = formData.userId;

  Product.fromJson(String productId, dynamic productData)
      // the productData is really a Map<String, dynamic>
      : productId = productId,
        title = productData['title'],
        description = productData['description'],
        price = productData['price'],
        imageUrl = productData['imageUrl'],
        location = productData['location'],
        isFavorite = productData['isFavorite'],
        userEmail = productData['userEmail'],
        userId = productData['userId'];

  Map<String, dynamic> toProductData() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'location': location,
      'isFavorite': isFavorite,
      'userEmail': userEmail,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return '''{
  productId:$productId,
  title:'$title',
  description:'$description',
  price:$price,
  imageUrl:'$imageUrl',
  location:'$location',
  isFavorite:$isFavorite,
  userEmail:'$userEmail',
  userId:'$userId',
}''';
  }
}
