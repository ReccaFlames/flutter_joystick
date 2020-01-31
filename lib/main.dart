import 'package:flutter/material.dart';
import 'package:flutter_joystick/buttons_view.dart';
import 'package:flutter_joystick/joystick.dart';

import 'commons/landscape_stateful_mixin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Joystick',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Joystick Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with LandscapeStatefulModeMixin<MyHomePage> {
  bool _mode = false;
  bool _sendData = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'MODE',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                            value: _mode,
                            onChanged: (value) {
                              _mode = value;
                            }),
                      ],
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'SEND',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                            value: _sendData,
                            onChanged: (value) {
                              _sendData = value;
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Joystick(),
                    PadButtonsView(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.settings),
                      color: Colors.grey,
                      onPressed: () {})
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // Center is a layout widget. It takes a single child and positions it
  }

  @override
  void dispose() {
    super.dispose();
  }
}
