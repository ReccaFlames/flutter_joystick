import 'dart:math' as _math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/components/pad_button.dart';

typedef PadButtonPressedCallback = void Function(
    int buttonIndex, String gesture);

class PadButtonsView extends StatelessWidget {
  final double size;

  final List<PadButton> buttons;

  final PadButtonPressedCallback onButtonPressed;

  final double buttonsPadding;

  final Color buttonColor;

  PadButtonsView({
    this.size,
    this.buttons = const [
      PadButton(index: 0, buttonText: "R"),
      PadButton(index: 1, buttonText: "L"),
    ],
    this.onButtonPressed,
    this.buttonsPadding = 0,
    this.buttonColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    double actualSize = size != null
        ? size
        : _math.min(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height) *
            0.5;
    double innerCircleSize = actualSize / 3;
    return Center(
      child: Stack(
        children: createButtons(actualSize, innerCircleSize),
      ),
    );
  }

  List<Widget> createButtons(double actualSize, double innerCircleSize) {
    List<Widget> list = List();
    list.add(Container(
      width: actualSize,
      height: actualSize,
    ));
    for (int i = 0; i < buttons.length; i++) {
      list.add(createPositionedButton(
        buttons[i],
        i,
        actualSize,
        innerCircleSize,
      ));
    }
    return list;
  }

  Positioned createPositionedButton(
      PadButton button, int index, actualSize, double innerCircleSize) {
    return Positioned(
      child: StatefulBuilder(
        builder: (context, setState) {
          return GestureDetector(
            onTap: () {
              _processGesture(button, 'onTap');
            },
            onTapUp: (details) {
              _processGesture(button, 'onTapUp');
            },
            onTapDown: (details) {
              _processGesture(button, 'onTapDown');
            },
            onTapCancel: () {
              _processGesture(button, 'onTapCancel');
            },
            onLongPress: () {
              _processGesture(button, 'onLongPress');
            },
            onLongPressStart: (details) {
              _processGesture(button, 'onLongPressStart');
            },
            onLongPressUp: () {
              _processGesture(button, 'onLongPressUp');
            },
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                width: innerCircleSize,
                height: innerCircleSize,
                child: Center(
                  child: (button.buttonText != null)
                      ? Text(button.buttonText,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),)
                      : null,
                ),
                decoration: BoxDecoration(
                  color: buttonColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black26,
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
                ),
              ),
            ),
          );
        },
      ),
      top: _calculatePositionY(index, innerCircleSize, actualSize),
      left: _calculatePositionX(index, innerCircleSize, actualSize),
    );
  }

  void _processGesture(PadButton button, String gesture) {
    if(onButtonPressed != null) {
      onButtonPressed(button.index, gesture);
    }
  }

  double _calculatePositionX(
      int index, double innerCircleSize, double actualSize) {
    double degrees = 360 / buttons.length * index;
    double lastAngleRadians = (degrees) * (_math.pi / 180.0);

    var rBig = actualSize / 2;
    var rSmall = (innerCircleSize + 2 * buttonsPadding) / 2;

    return (rBig - rSmall) + (rBig - rSmall) * _math.cos(lastAngleRadians);
  }

  double _calculatePositionY(
      int index, double innerCircleSize, double actualSize) {
    double degrees = 360 / buttons.length * index;
    double lastAngleRadians = (degrees) * (_math.pi / 180.0);
    var rBig = actualSize / 2;
    var rSmall = (innerCircleSize + 2 * buttonsPadding) / 2;

    return (rBig - rSmall) + (rBig - rSmall) * _math.sin(lastAngleRadians);
  }
}
