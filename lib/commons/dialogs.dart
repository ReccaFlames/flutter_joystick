import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Dialogs {
  static Future<Color> colorPickerDialog(
    BuildContext context,
    Color currentColor,
  ) async {
    final color = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Color pickerColor;
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            titlePadding: const EdgeInsets.all(0.0),
            contentPadding: const EdgeInsets.all(5.0),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: currentColor,
                onColorChanged: (Color color) {
                  pickerColor = color;
                },
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: true,
                displayThumbColor: true,
                enableLabel: true,
                paletteType: PaletteType.hsv,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Got it'),
                onPressed: () {
                  Navigator.of(context).pop(pickerColor);
                },
              ),
            ],
          );
        });
    return (color != null) ? color : currentColor;
  }
}
