import 'package:flutter/material.dart';

class CircleView extends StatelessWidget {
  final double size;

  final Color color;

  final List<BoxShadow> boxShadow;

  final Border border;

  final double opacity;

  CircleView({
    this.size,
    this.color = Colors.transparent,
    this.boxShadow,
    this.border,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: border,
        boxShadow: boxShadow,
      ),
    );
  }

  factory CircleView.joystickCircle(double size, Color color) => CircleView(
    size: size,
    color: color,
    border: Border.all(
      color: Colors.black12,
      width: 4.0,
      style: BorderStyle.solid,
    ),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 8.0,
        blurRadius: 8.0,
      )
    ],
  );

  factory CircleView.joystickKnob(double size, Color color) =>
      CircleView(
        size: size,
        color: color,
        border: Border.all(
          color: Colors.black87,
          width: 2.0,
          style: BorderStyle.solid,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 8.0,
            blurRadius: 8.0,
          )
        ],
      );
}