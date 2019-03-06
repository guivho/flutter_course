// import 'package:uuid/uuid.dart';
import './product.dart';
import './user.dart';

import '../utils/constants.dart';

class FormData {
  String title;
  String description;
  double price;
  String location;
  String imageUrl;
  String favoredBy;
  String userId;
  String userEmail;

  FormData(Product product, User user) {
    this.title = product == null ? '' : product.title;
    this.description = product == null ? '' : product.description;
    this.price = product == null ? 0.0 : product.price;
    this.location = 'Union Square, San Francisco';
    this.imageUrl = // 'assets/food.jpg';
        'https://cdn.pixabay.com/photo/2015/10/02/12/00/chocolate-968457_960_720.jpg';
    this.favoredBy = product == null ? '' : product.favoredBy;
    this.userId = product == null ? user.userId : product.userId;
    this.userEmail = product == null ? user.email : product.userEmail;
  }

  // used to create json input before adding product
  Map<String, dynamic> toJson(String email, String userId) {
    return {
      P_TITLE: this.title,
      P_DESCRIPTION: this.description,
      P_PRICE: this.price,
      P_LOCATION: this.location,
      P_IMAGEURL: this.imageUrl,
      P_FAVOREDBY: this.favoredBy,
      P_USERID: userId,
      P_USEREMAIL: userEmail,
    };
  }
}
