import 'package:uuid/uuid.dart';
import './product.dart';

class FormData {
  String id;
  String title;
  String description;
  double price;
  String location;
  String imageUrl;
  bool isFavorite;

  FormData() {
    this.id = Uuid().v1();
    this.title = '';
    this.description = '';
    this.price = 0.0;
    this.location = 'Union Square, San Francisco';
    this.imageUrl =
        'https://www.laurasbakery.nl/wp-content/uploads/2015/12/snelle-chocolade-fudge-1a.jpg';
    this.isFavorite = false;
  }

  Product toProduct() {
    return Product(
      id: this.id,
      title: this.title,
      description: this.description,
      price: this.price,
      location: this.location,
      imageUrl: this.imageUrl,
      isFavorite: this.isFavorite,
      userEmail: '',
      userId: '',
    );
  }
}
