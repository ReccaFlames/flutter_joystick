import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/commons/landscape_stateful_mixin.dart';

class ColorsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ColorsPageState();
}

class ColorsPageState extends State<ColorsPage> with LandscapeStatefulModeMixin<ColorsPage>{
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
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[700], //change your color here
        ),
      ),
      body: ListView(
        children: <Widget>[

        ],
      ),
    );
  }

}