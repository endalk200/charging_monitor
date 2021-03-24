import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:battery/battery.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class HomeScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
        body: Body(),
        );
    }
}

class Body extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        // Size size = MediaQuery.of(context).size;

        return Background();
    }
}

class Background extends StatefulWidget {
    @override
    _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {

    final Battery _battery = Battery();

    String? _batteryState;
    int? _batteryLevel;

    void _getBatteryLevel() async {
        var level;

        level = await _battery.batteryLevel;

        this.setState(() {
            _batteryLevel = level;
        });

        _battery.onBatteryStateChanged.listen((BatteryState state) async {
            level = await _battery.batteryLevel;
            this.setState(() {
                _batteryLevel = level;
                _batteryState = _parseBatteryState(state);
            });
            // if (level >= 80) {
            //     // FlutterRingtonePlayer.playNotification();
            //     FlutterRingtonePlayer.play(
            //         android: AndroidSounds.notification,
            //         ios: IosSounds.glass,
            //         looping: false, // Android only - API >= 28
            //         volume: 5, // Android only - API >= 28
            //         asAlarm: false, // Android only - all APIs
            //     );
            // } else {
            //     FlutterRingtonePlayer.stop();
            // }
        });
    }

    @override
    Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
        _getBatteryLevel();
        return Scaffold(
            appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('Page title'),
            actions: [
                Padding(padding: EdgeInsets.all(0.5), child: Icon(Icons.more_vert),)
            ],
            backgroundColor: Color.fromRGBO(2, 128, 144, 0), // 0, 18, 20, 0
        ),
        body: ListView(
            children: [
            Container(
                height: size.height,
                width: double.infinity,
                child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                    Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                        "assets/images/main_top.png",
                        width: size.width * 0.3,
                    ),
                    ),
                    Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                        "assets/images/main_bottom.png",
                        width: size.width * 0.2,
                    ),
                    ),
                    ListView(
                    children: [
                        Card(
                        margin: EdgeInsets.all(20.0),
                        color: Colors.white,
                        elevation: 50.0,
                        child: Container(
                            height: 140,
                            child: Container(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                    "assets/icons/battery.svg",
                                    color: Colors.green,
                                    height: size.height * 0.1,
                                ),
                            )),
                        ),
                        Card(
                        margin: EdgeInsets.all(40.0),
                        color: Colors.white,
                        elevation: 10.0,
                        child: Container(
                            height: 140,
                            child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                _batteryState.toString() + "%",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                ),
                                ),
                            )),
                        ),
                    ],
                    ),
                ],
                ),
            ),
            ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            onTap: (value) {
            // Respond to item press.
            },
            items: [
                BottomNavigationBarItem(
                    title: Text('About'),
                    icon: Icon(Icons.favorite),
                ),
                BottomNavigationBarItem(
                    title: Text('Setting'),
                    icon: Icon(Icons.settings),
                ),
            ],
            ),
        );
    }

    String _parseBatteryState(BatteryState state) {
        var stateString;
        switch (state) {
        case BatteryState.charging:
            stateString = "Charging";
            break;
        case BatteryState.discharging:
            stateString = "Discharging";
            break;
        case BatteryState.full:
            stateString = "Fully Charged";
            break;
        }
        return stateString;
    }
}
