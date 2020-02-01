import 'package:flutter/material.dart';

class CircleSwatch extends StatelessWidget {

  final double rad;
  final Color color;
  final Color borderColor;

  CircleSwatch({
    this.rad = 30.0,
    this.color = Colors.white,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: rad,
      height: rad,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 2.0,
            blurRadius: 2.0,
          )
        ],
      ),
    );
  }
}
