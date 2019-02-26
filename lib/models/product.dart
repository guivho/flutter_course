import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String location;
  final String imageUrl;
  final bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.location,
    @required this.imageUrl,
    @required this.isFavorite,
  });

  Product toggleFavorite() {
    return Product(
      id: this.id,
      title: this.title,
      description: this.description,
      price: this.price,
      imageUrl: this.imageUrl,
      location: this.location,
      isFavorite: !this.isFavorite,
    );
  }
}
