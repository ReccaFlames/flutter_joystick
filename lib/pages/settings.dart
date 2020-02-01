import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/pages/endpoint.dart';

import '../commons/landscape_stateful_mixin.dart';
import 'colors.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>
    with LandscapeStatefulModeMixin<SettingsPage> {
  bool _devMode = false;
  String _url = 'https://jsonplaceholder.typicode.com/posts';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.grey[700]),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[700], //change your color here
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Colors'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              navigateToColorsPage();
            },
          ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('Endpoint'),
            trailing: Text(
              '$_url',
              style: TextStyle(color: Colors.grey[700]),
            ),
            onTap: () {
              navigateToEditEndpointPage();
            },
          ),
          ListTile(
            leading: Icon(Icons.developer_mode),
            title: Text('Developer mode'),
            trailing: Switch(
              value: _devMode,
              onChanged: (value) => setDevMode(value),
            ),
            onTap: () {
              setDevMode(!_devMode);
            },
          ),
        ],
      ),
    );
  }

  navigateToEditEndpointPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditEndpointPage()),
    );
  }

  navigateToColorsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ColorsPage()),
    );
  }

  void setDevMode(bool value) {
    setState(() {
      _devMode = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
