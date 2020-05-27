import 'package:cron/cron.dart';

import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/userFiles/user.dart' as userlib;

LatLng latLng;
sharePos() {
  getLocation();
  var cron = new Cron();
  cron.schedule(new Schedule.parse('* * * * *'), () async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm').format(now);
    print(formattedDate +
        " MY POS: " +
        latLng.latitude.toString() +
        " , " +
        latLng.longitude.toString());
    var url = 'https://group6-15.pvt.dsv.su.se/user/location';

    var response = await http.post(Uri.parse(url), body: {
      'lat': latLng.latitude,
      'log': latLng.longitude,
      'uid': userlib.uid
    });
    print(response.statusCode);
  });
}

void getLocation() async {
  var location = new Location();
  location.onLocationChanged().listen((currentLocation) {
    latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
  });
}
