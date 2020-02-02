import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/commons/dialogs.dart';
import 'package:flutter_joystick/commons/landscape_stateful_mixin.dart';
import 'package:flutter_joystick/commons/shared_preferences_helper.dart';
import 'package:flutter_joystick/components/circle_swatch.dart';

class ColorsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ColorsPageState();
}

class ColorsPageState extends State<ColorsPage> with LandscapeStatefulModeMixin<ColorsPage>{

  Color joystickColor;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    fetchBuildData();
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
          color: Colors.grey[700],
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
              SharedPreferencesHelper.setJoystickColor(color);
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
              SharedPreferencesHelper.setBackgroundColor(color);
              setState(() => backgroundColor = color);
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchBuildData();
  }

  void fetchBuildData() {
    SharedPreferencesHelper.getJoystickColor().then((onValue) {
      setState(() {
        joystickColor = onValue;
      });
    });
    SharedPreferencesHelper.getBackgroundColor().then((onValue) {
      setState(() {
        backgroundColor = onValue;
      });
    });
  }

}