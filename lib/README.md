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

  BatteryState? _batteryState;
  late StreamSubscription<BatteryState> _batteryStateSubscription;

  @override
  void initState() {
    super.initState();

    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        _batteryState = state;
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
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.battery_std_sharp, size: 72.0),
                title: Text('Battery Status '),
                subtitle: Text('This is a subtitle.'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.battery_unknown),
        onPressed: () async {
          final int batteryLevel = await _battery.batteryLevel;
          // ignore: unawaited_futures
          showDialog<void>(
            context: context,
            builder: (_) => AlertDialog(
              content: Text('Battery: $batteryLevel%'),
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
    // ignore: unnecessary_null_comparison
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription.cancel();
    }
  }
}

