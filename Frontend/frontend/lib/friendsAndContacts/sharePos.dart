import 'dart:async';

import 'package:cron/cron.dart';

import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/userFiles/user.dart' as userlib;

Timer timer;
LatLng latLng;
sharePos() async {
  if(latLng != null) {
  var url = 'https://group6-15.pvt.dsv.su.se/user/location';
  var response = await http.post((url), body: {
    'lat': latLng.latitude.toString(),
    'log': latLng.longitude.toString(),
    'uid': userlib.uid
  });
  print(response.statusCode);
  }
}

void initState() {
  getLocation();
  timer = Timer.periodic(Duration(seconds: 15), (Timer t) => sharePos());
}

void dispose() {
  timer?.cancel();
}

void getLocation() async {
  var location = new Location();
  location.onLocationChanged.listen((currentLocation) {
    latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
  });
}
