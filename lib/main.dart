import 'package:flutter/material.dart';
import 'package:flutter_joystick/joystick.dart';

import 'commons/landscape_stateful_mixin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Joystick',
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
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Joystick(),
          ],
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
