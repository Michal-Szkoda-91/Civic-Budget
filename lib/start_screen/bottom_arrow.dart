import 'package:flutter/material.dart';

class BottomArrow extends StatelessWidget {
  final BoxConstraints constraints;

  const BottomArrow({Key key, this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: constraints.maxHeight < 650
          ? constraints.maxHeight * 0.07
          : constraints.maxHeight * 0.05,
      color: Theme.of(context).accentColor,
      child: Center(
        child: Icon(
          Icons.arrow_upward,
          color: Theme.of(context).primaryColor,
          size: 30,
        ),
      ),
    );
  }
}
