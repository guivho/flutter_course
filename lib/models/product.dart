import 'package:flutter/material.dart';

import './form_data.dart';
import '../utils/constants.dart';

class Product {
  final String productId;
  final String title;
  final String description;
  final double price;
  final String location;
  final String imageUrl;
  final String userId;
  final String userEmail;
  final String favoredBy;

  Product({
    @required this.productId,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.location,
    @required this.imageUrl,
    @required this.favoredBy,
    @required this.userId,
    @required this.userEmail,
  });

  Product toggleFavoriteFor(String userId) {
    final String userRecord = '$P_OPENSEP$userId$P_CLOSESEP';
    String favor = this.favoredBy;
    final int pos = favoredBy.indexOf(userRecord);
    if (pos < 0) {
      favor = '$userRecord$favor';
    } else if (pos == 0) {
      favor = favor.substring(userRecord.length);
    } else {
      favor =
          '${favor.substring(0, pos)}${favor.substring(pos + userRecord.length)}';
    }
    return Product(
      productId: this.productId,
      title: this.title,
      description: this.description,
      price: this.price,
      imageUrl: this.imageUrl,
      location: this.location,
      favoredBy: favor,
      userId: this.userId,
      userEmail: this.userEmail,
    );
  }

  // toggleFavorite(String userId) {
  //   // return true if user now listed in favoredBy
  //   final String userRecord = '$P_OPENSEP$userId$P_CLOSESEP';
  //   final int pos = favoredBy.indexOf(userRecord);
  //   if (pos < 0) {
  //     favoredBy = '$userRecord$favoredBy';
  //   } else if (pos == 0) {
  //     favoredBy = favoredBy.substring(userRecord.length);
  //   } else {
  //     favoredBy =
  //         '${favoredBy.substring(0, pos)}${favoredBy.substring(pos + userRecord.length)}';
  //   }
  //   return pos < 0;
  // }

  Product.fromForm(String productId, FormData formData)
      : productId = productId,
        title = formData.title,
        description = formData.description,
        price = formData.price,
        imageUrl = formData.imageUrl,
        location = formData.location,
        favoredBy = formData.favoredBy,
        userId = formData.userId,
        userEmail = formData.userEmail;

  Product.fromJson(
      String productId, Map<String, dynamic> parsedJson, String userId)
      : // the parsedJson is really a Map<String, dynamic>
        productId = productId,
        title = parsedJson[P_TITLE],
        description = parsedJson[P_DESCRIPTION],
        price = parsedJson[P_PRICE],
        imageUrl = parsedJson[P_IMAGEURL],
        location = parsedJson[P_LOCATION],
        favoredBy = parsedJson[P_FAVOREDBY],
        userId = parsedJson[P_USERID],
        userEmail = parsedJson[P_USEREMAIL];

  Map<String, dynamic> toJson() {
    return {
      P_TITLE: title,
      P_DESCRIPTION: description,
      P_PRICE: price,
      P_IMAGEURL: imageUrl,
      P_LOCATION: location,
      P_FAVOREDBY: favoredBy,
      P_USERID: userId,
      P_USEREMAIL: userEmail,
    };
  }

  @override
  String toString() {
    return '''{
  $P_PRODUCTID:$productId,
  $P_TITLE:'$title',
  $P_DESCRIPTION:'$description',
  $P_PRICE:$price,
  $P_IMAGEURL:'$imageUrl',
  $P_LOCATION:'$location',
  $P_FAVOREDBY:'$favoredBy',
  $P_USERID:'$userId',
  $P_USEREMAIL:'$userEmail',
}''';
  }

  bool isFavoredBy(String userId) {
    return favoredBy.indexOf('$P_OPENSEP$userId$P_CLOSESEP') >= 0;
  }
}

class Favor {
  String userId;
  bool like;

  Favor.fromJson(Map<String, dynamic> jsonMap) {
    this.userId = jsonMap[P_USERID];
  }
}
