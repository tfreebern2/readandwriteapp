import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    title: 'SharedPrefs',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = new TextEditingController();
  String _savedData = "";

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      if (preferences.getString('data').isNotEmpty && preferences.getString('data') != null) {
        _savedData = preferences.getString("data");
      } else {
        _savedData = "Empty SP";
      }

    });
  }

  _saveMessage(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('data', message); // key : value ==> "paulo" : "smart"

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPrefs'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _enterDataField,
                  decoration: InputDecoration(labelText: 'Write Something'),
                ),
              ),
              FlatButton(
                child: Text('Save Data'),
                color: Colors.green,
                onPressed: () {
                  _saveMessage(_enterDataField.text);
                },
              ),
              Padding(
                padding: EdgeInsets.all(14.5),
              ),
              Text(_savedData),
//              FutureBuilder(
//                future: readData(),
//                builder: (BuildContext context, AsyncSnapshot<String> data) {
//                  if (data.hasData != null) {
//                    return Text(
//                      data.data.toString(),
//                      style: TextStyle(color: Colors.blueAccent),
//                    );
//                  } else {
//                    return Text("No data saved");
//                  }
//                },
//              )
            ],
          ),
        ],
      ),
    );
  }
}