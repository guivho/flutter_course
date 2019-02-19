import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double _price;

  PriceTag(this._price);

  @override
  DecoratedBox build(BuildContext context) {
    return DecoratedBox(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Text('€${_price.toString()}'),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Theme.of(context).primaryColorLight,
      ),
    );
  }
}
