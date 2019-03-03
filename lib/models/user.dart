import 'package:flutter/material.dart';
import '../utils/constants.dart';

class User {
  final String userId;
  final String email;
  final String password;

  User({
    @required this.userId,
    @required this.password,
    @required this.email,
  });

  User.fromJson(dynamic userData, String password)
      : // userData is really a Map<String, dynamic>
        userId = userData[FB_LOCALID],
        email = userData[FB_EMAIL],
        password = password;

  @override
  toString() {
    return '''
userId: '$userId',
email: '$email',
password: '$password',
''';
  }
}
