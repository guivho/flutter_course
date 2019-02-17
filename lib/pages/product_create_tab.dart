import 'package:flutter/material.dart';

class ProductCreateTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: RaisedButton(
        child: Text('Save'),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Text('Hi, I am a modal!'),
              );
            },
          );
        },
      ),
    );
  }
}
