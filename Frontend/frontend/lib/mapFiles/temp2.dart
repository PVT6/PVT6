import 'package:flutter/material.dart';
import 'dart:async';
import 'package:frontend/mapFiles/finishedRoutePage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:geolocator/geolocator.dart' as geo;

class Navigation extends StatefulWidget {
  final double userLat;
  final double userLng; //
  Navigation(this.userLat, this.userLng);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Navigation> {
  String _platformVersion = 'Android';
  static double userLat = 0;
  static double userLng = 0;
  bool nextPoint = false;
  static geo.Position position;

  Location _origin = Location(name: "My Location", latitude: 0, longitude: 0);
  Location _destination =
      Location(name: "Lumaparken", latitude: 59.303985, longitude: 18.097073);

  MapboxNavigation _directions;
  bool _arrived = false;
  double _distanceRemaining, _durationRemaining;

  @override
  void initState() {
    super.initState();
    getLocation();
    // userLat = widget.userLat;
    // userLng = widget.userLng;
    getDestination();
    initPlatformState();
  }

  Future<void> getLocation() async {
    geo.Position temp = await geo.Geolocator()
        .getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
    setState(() {
      position = temp;
    });
    setLocation();
  }

  Future<void> setLocation() async {
    Location _origin1 = Location(
        name: "My Location",
        latitude: position.latitude,
        longitude: position.longitude);
    _origin = _origin1;
  }

  Future<void> getDestination() async {
    setState(() {
      userLat = widget.userLat;
      userLng = widget.userLng;
    });
    setDestination();
  }

  Future<void> setDestination() async {
    Location _destination1 =
        Location(name: "My Location", latitude: userLat, longitude: userLng);
    _destination = _destination1;
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
        // setState(() {
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context) => FinishedRoutePage()));
        // });
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
                    simulateRoute: true,
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
