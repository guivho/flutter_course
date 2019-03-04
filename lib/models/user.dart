import 'package:flutter/material.dart';
import '../utils/constants.dart';

class User {
  final String userId;
  final String email;
  final String token;

  User({
    @required this.userId,
    @required this.email,
    @required this.token,
  });

  User.fromJson(dynamic userData)
      : // userData is really a Map<String, dynamic>
        // from Firebase response after signing up
        userId = userData[FB_LOCALID],
        email = userData[FB_EMAIL],
        token = userData[FB_IDTOKEN];

  @override
  toString() {
    return '''
userId: '$userId',
email: '$email',
token: '$token',
''';
  }
}
