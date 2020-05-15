import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';

class Navigation extends StatefulWidget {
  final double userLat;
  final double userLng;
  Navigation(this.userLat, this.userLng);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Navigation> {
  String _platformVersion = 'Android';
  static double userLat = 0;
  static double userLng = 0;

  Location _origin =
      Location(name: "City Hall", latitude: userLat, longitude: userLng);
  Location _destination =
      Location(name: "Downtown Buffalo", latitude: 59.3693, longitude: 17.8634);

  MapboxNavigation _directions;
  bool _arrived = false;
  double _distanceRemaining, _durationRemaining;

  @override
  void initState() {
    super.initState();
    userLat = widget.userLat;
    userLng = widget.userLng;
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    _directions = MapboxNavigation(onRouteProgress: (arrived) async {
      _distanceRemaining = await _directions.distanceRemaining;
      _durationRemaining = await _directions.durationRemaining;

      setState(() {
        _arrived = arrived;
      });
      if (arrived) {
        await Future.delayed(Duration(seconds: 3));
        await _directions.finishNavigation();
      }
    });

    String platformVersion;
    try {
      platformVersion = await _directions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Navigation'),
        ),
        body: Center(
          child: Column(children: <Widget>[
            SizedBox(
              height: 30,
            ),
            //Text('Running on: $_platformVersion\n'),
            SizedBox(
              width: 150,
              height: 120,
              child: Image.asset(
                'assets/logopurplepink.png',
              ),
            ),
            SizedBox(
              height: 60,
            ),
            RaisedButton(
              child: Text("Start Navigation"),
              onPressed: () async {
                await _directions.startNavigation(
                    origin: _origin,
                    destination: _destination,
                    mode: NavigationMode.walking,
                    simulateRoute: false,
                    language: "English",
                    units: VoiceUnits.metric);
              },
            ),
            SizedBox(
              height: 60,
            ),
            Text("Preview karta här nedan")
          ]),
        ),
      ),
    );
  }
}
