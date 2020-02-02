import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/commons/landscape_stateful_mixin.dart';
import 'package:flutter_joystick/commons/shared_preferences_helper.dart';

class EditEndpointPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditEndpointPageState();
}

class EditEndpointPageState extends State<EditEndpointPage>
    with LandscapeStatefulModeMixin<EditEndpointPage> {
  TextEditingController myController;
  String endpointUrl;

  final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Colors.black));

  formFieldDecoration({String labelText}) {
    return InputDecoration(
      disabledBorder: border,
      border: border,
      labelText: labelText,
    );
  }

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
            onPressed: () {
              saveUrlData(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: myController,
          decoration: formFieldDecoration(
            labelText: 'Endpoint',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchUrlData();
  }

  void fetchUrlData() {
    SharedPreferencesHelper.getEndpointUrl().then((url) {
      setState(() {
        endpointUrl = url;
        myController = new TextEditingController(text: url);
      });
    });
  }

  void saveUrlData(BuildContext context) {
    String newUrl = myController.text;
    if (newUrl != endpointUrl) {
      SharedPreferencesHelper.setEndpointUrl(newUrl).then((bool commited) {
        if (commited) {
          Navigator.of(context).pop();
        }
      });
    }
  }
}
