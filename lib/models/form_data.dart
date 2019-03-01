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
    this.imageUrl = // 'assets/food.jpg';
        'https://cdn.pixabay.com/photo/2015/10/02/12/00/chocolate-968457_960_720.jpg';
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
