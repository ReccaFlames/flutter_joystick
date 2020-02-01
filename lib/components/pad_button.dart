import 'package:flutter/material.dart';

class PadButton {
  final int index;

  final String buttonText;

  final Image buttonImage;

  final Color backgroundColor;

  final Color pressedColor;

  const PadButton({
    @required this.index,
    this.buttonText,
    this.buttonImage,
    this.backgroundColor = Colors.white54,
    this.pressedColor = Colors.lightBlueAccent,
  }) : assert(index != null);
}