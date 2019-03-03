import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

void main() async {
  var data = await readData();

  if (data != null) {
    String message = await readData();
    print(message);
  }

  runApp(MaterialApp(
    title: 'IO',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read/Write'),
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
                  writeData(_enterDataField.text);
                },
              ),
              Padding(
                padding: EdgeInsets.all(14.5),
              ),
              FutureBuilder(
                future: readData(),
                builder: (BuildContext context, AsyncSnapshot<String> data) {
                  if (data.hasData != null) {
                    return Text(
                      data.data.toString(),
                      style: TextStyle(color: Colors.blueAccent),
                    );
                  } else {
                    return Text("No data saved");
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path; //home/directory/
}

Future<File> get _localFile async {
  final path = await _localPath;

  return new File('$path/data.txt'); //home/directory/data.txt
}

// Write and Read from text file
Future<File> writeData(String message) async {
  final file = await _localFile;

  return file.writeAsString('$message');
}

Future<String> readData() async {
  try {
    final file = await _localFile;

    // read
    String data = await file.readAsString();

    return data;
  } catch (e) {
    debugPrint(e.toString());

    return 'Nothing saved!!';
  }
}
