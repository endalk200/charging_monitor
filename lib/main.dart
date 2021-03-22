import 'dart:async';

import 'package:flutter/material.dart';
import 'package:battery/battery.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charging Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Charging Monitor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Battery _battery = Battery();

  late BatteryState _battery_state;
  late int _battery_level;
  late String _name = "Endalk";

  @override
  void initState() {
    super.initState();

    _battery.batteryLevel.then((level) {
      this.setState(() {
        _battery_level = level;
      });
    });

    _battery.onBatteryStateChanged.listen((BatteryState state) {
      _battery.batteryLevel.then((level) {
        this.setState(() {
          _battery_level = level;
          _battery_state = state;
        });
      });
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Container(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.battery_std_sharp, size: 50.0),
                  title: Text('Battery Status '),
                  subtitle: Text('This is a subtitle. $_name'),
                ),
              ],
            ),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.battery_unknown),
        onPressed: () async {

          // ignore: unawaited_futures
          showDialog<void>(
            context: context,
            builder: (_) => AlertDialog(
              content: Text('Battery: 100%'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

