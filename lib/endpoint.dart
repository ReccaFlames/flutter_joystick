import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/commons/landscape_stateful_mixin.dart';

class EditEndpointPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditEndpointPageState();
}

class EditEndpointPageState extends State<EditEndpointPage>
    with LandscapeStatefulModeMixin<EditEndpointPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Url',
          style: TextStyle(color: Colors.grey[700]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.grey[700], //change your color here
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.grey[700], //change your color here
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
          )
        ],
      ),
    );
  }
}
