import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/circle_swatch.dart';
import 'package:flutter_joystick/commons/dialogs.dart';
import 'package:flutter_joystick/commons/landscape_stateful_mixin.dart';

class ColorsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ColorsPageState();
}

class ColorsPageState extends State<ColorsPage> with LandscapeStatefulModeMixin<ColorsPage>{

  Color joystickColor = Color(0xff443a49);
  Color backgroundColor = Color(0xff443a49);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Colors',
          style: TextStyle(color: Colors.grey[700]),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[700], //change your color here
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            trailing: CircleSwatch(color: joystickColor,),
            title: Text(
              'Joystick & buttons',
            ),
            onTap: () async {
              final color = await Dialogs.colorPickerDialog(context, joystickColor);
              setState(() => joystickColor = color);
            },
          ),
          ListTile(
            trailing: CircleSwatch(color: backgroundColor,),
            title: Text(
              'Background',
            ),
            onTap: () async {
              final color = await Dialogs.colorPickerDialog(context, backgroundColor);
              setState(() => backgroundColor = color);
            },
          ),
        ],
      ),
    );
  }

  createCircleSwatch(double rad, Color color) {
    return Container(
      width: rad,
      height: rad,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey[400],
          width: 2.0,
          style: BorderStyle.solid,
        )
      ),
    );
  }

}