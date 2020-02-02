import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_joystick/commons/shared_preferences_helper.dart';
import 'package:flutter_joystick/components/buttons_view.dart';
import 'package:flutter_joystick/components/joystick.dart';
import 'package:flutter_joystick/pages/settings.dart';
import 'package:sensors/sensors.dart';

import '../commons/json_sender.dart';
import '../commons/landscape_stateful_mixin.dart';
import '../models/movement.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with LandscapeStatefulModeMixin<HomePage> {
  String url = 'https://jsonplaceholder.typicode.com/posts';

  Color joystickColor;
  Color backgroundColor;

  bool _mode = false;
  bool _sendData = false;

  AccelerometerEvent acceleration;
  StreamSubscription<AccelerometerEvent> _streamSubscription;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    fetchBuildData();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            color: backgroundColor,
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
                              color: Colors.white,
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
                              color: Colors.white,
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
                        backgroundColor: joystickColor,
                        innerCircleColor: joystickColor,
                        onDirectionChanged: (double degrees, Offset offset) {
                          if (!_mode) {
                            print('${offset.dx} , ${offset.dy}');
                            sendData(offset.dy, offset.dx, 0.0);
                          }
                        },
                      ),
                      PadButtonsView(
                        buttonColor: joystickColor,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.settings),
                        color: Colors.white,
                        onPressed: () => navigateToSettingsPage()),
                  ],
                ),
              ],
            ),
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

  void fetchBuildData() {
    SharedPreferencesHelper.getJoystickColor().then((onValue) {
      joystickColor = onValue;
    });
    SharedPreferencesHelper.getBackgroundColor().then((onValue) {
      backgroundColor = onValue;
    });
  }

  void startup() async {
    Color joystick = await SharedPreferencesHelper.getJoystickColor();
    Color background = await SharedPreferencesHelper.getBackgroundColor();

    setState(() {
      joystickColor = joystick;
      backgroundColor = background;
    });
  }

  @override
  void initState() {
    super.initState();
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      readAccelerationData(event);
    });
    startup();
  }
}
