import 'package:flutter/material.dart';

class Util {
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Something went wrong'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  static void showTryAgainDialog(BuildContext context) {
    showErrorDialog(context, 'Please try again!');
  }
}
