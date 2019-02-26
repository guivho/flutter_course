import 'package:flutter/material.dart';

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

  Product toggleFavorite() {
    return Product(
      id: id,
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
      location: location,
      userEmail: userEmail,
      userId: userId,
      isFavorite: !isFavorite,
    );
  }

  Map<String, dynamic> toMapForDb() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price.toString(),
      'location': location,
      'imageUrl':
          'https://cdn.pixabay.com/photo/2013/09/18/18/24/chocolate-183543_1280.jpg',
      'isFavorite': isFavorite ? 1 : 0,
      'userEmail': userEmail,
      'userId': userId,
    };
  }
}
