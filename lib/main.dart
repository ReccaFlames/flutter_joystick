import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_joystick/buttons_view.dart';
import 'package:flutter_joystick/joystick.dart';
import 'package:flutter_joystick/settings.dart';
import 'package:sensors/sensors.dart';

import 'commons/json_sender.dart';
import 'commons/landscape_stateful_mixin.dart';
import 'movement.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with LandscapeStatefulModeMixin<MyHomePage> {
  String url = 'https://jsonplaceholder.typicode.com/posts';

  bool _mode = false;
  bool _sendData = false;

  AccelerometerEvent acceleration;
  StreamSubscription<AccelerometerEvent> _streamSubscription;

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
                              setState(() {
                                _mode = value;
                              });
                              _mode
                                  ? _streamSubscription.resume()
                                  : _streamSubscription.pause();
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
                    Joystick(
                      onDirectionChanged: (double degrees, Offset offset) {
                        if (!_mode) {
                          print('${offset.dx} , ${offset.dy}');
                          sendData(offset.dy, offset.dx, 0.0);
                        }
                      },
                    ),
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
                      onPressed: () => navigateToSettingsPage()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // Center is a layout widget. It takes a single child and positions it
  }

  navigateToSettingsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }

  sendData(y, x, rotate) {
    if (_sendData) {
      String json = jsonEncode(Movement(y, x, rotate));
      JsonSender.createPost(json, url);
      print('send');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future readAccelerationData(AccelerometerEvent event) async {
    if (_mode) {
      acceleration = event;
      print('${acceleration.x} , ${acceleration.y}');
      sendData(acceleration.y, acceleration.x, 0.0);
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      readAccelerationData(event);
    });
  }
}
