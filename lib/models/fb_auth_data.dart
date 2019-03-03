import 'package:flutter/material.dart';
import '../utils/constants.dart';

class FbAuthData {
  final String email;
  final String password;
  final bool returnSecureToken = true;

  FbAuthData({
    @required this.email,
    @required this.password,
  });

  Map<String, dynamic> toMapStringDynamic() {
    return {
      FB_EMAIL: email,
      FB_PASSWORD: password,
      FB_RETURNSECURETOKEN: returnSecureToken,
    };
  }

  @override
  toString() {
    return '$FB_EMAIL: $email, $FB_PASSWORD: $password, $FB_RETURNSECURETOKEN: $returnSecureToken';
  }
}
