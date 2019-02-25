// import 'package:flutter/material.dart';

class Product {
  String id;
  String title;
  String description;
  double price;
  String location;
  String imageUrl;

  Product() {
    id = null;
    title = null;
    description = null;
    price = null;
    location = 'Union Square, San Francisco';
    imageUrl = 'assets/food.jpg';
  }

  // Product({
  //   @required this.id,
  //   @required title,
  //   @required description,
  //   @required price,
  //   @required location,
  //   @required imageUrl,
  // });
}
