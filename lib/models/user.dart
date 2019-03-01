import 'package:flutter/material.dart';

class User {
  final String userId;
  final String email;
  final String password;

  User({
    @required this.userId,
    @required this.password,
    @required this.email,
  });
}
