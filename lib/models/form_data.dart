// import 'package:uuid/uuid.dart';
// import './product.dart';

class FormData {
  String title;
  String description;
  double price;
  String location;
  String imageUrl;
  bool isFavorite;
  String userEmail;
  String userId;

  FormData() {
    this.title = '';
    this.description = '';
    this.price = 0.0;
    this.location = 'Union Square, San Francisco';
    this.imageUrl =
        'https://cdn.pixabay.com/photo/2013/09/18/18/24/chocolate-183543_1280.jpg';
    this.isFavorite = false;
    this.userEmail = '';
    this.userId = '';
  }

  Map<String, dynamic> toProductData(String email, String userId) {
    return {
      'title': this.title,
      'description': this.description,
      'price': this.price,
      'location': this.location,
      'imageUrl': this.imageUrl,
      'isFavorite': this.isFavorite,
      'userEmail': email,
      'userId': userId,
    };
  }
}
