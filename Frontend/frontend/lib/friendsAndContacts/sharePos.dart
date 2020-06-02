import 'dart:async';
import 'dart:convert';

import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/userFiles/user.dart' as userlib;
import 'package:frontend/mapFiles/mapsDemo.dart';

import 'contactsModel.dart';
List<User> updatedFriends = [];
List<PostionAndName> posName = [];

class PostionAndName {
  LatLng pos;
  String name;
  PostionAndName(this.name, this.pos);
}
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
  downloadFriendsPos();
  updateFriensPos();
  }
}

getFriensPos(){
  return posName;
}
downloadFriendsPos() async {
  var url = 'https://group6-15.pvt.dsv.su.se/contacts/all?uid=${userlib.uid}';
  var response = await http.get(Uri.parse(url));
  if (response.body != "") {
    final body = json.decode(response.body);

    print("LOAD FRIENDS");
    updatedFriends = (json.decode(jsonEncode(body["user"])) as List)
        .map((i) => User.fromJson(i))
        .toList();
    print(response.statusCode);
    posName.clear();
    print(updatedFriends);
    updatedFriends.forEach((element) {
      if(element.position != null){
        print(element.name);
        posName.add(new PostionAndName(element.name, new LatLng(element.position.y, element.position.x)));
      }
    });
    print(posName.first.pos);
  } else {
    print("NO FRIENDS");
    updatedFriends.clear();
  }
}

void testConnection(BuildContext context) async{
  var url = 'https://group6-15.pvt.dsv.su.se/version';
  var response = await http.get(Uri.parse(url));
  if(response.body == "1.2") { //should be 1.1 when done testing
    //return "DB CONNECTED";
  }
  else {
    showAlertDialog(context);
  }
}

void showAlertDialog(BuildContext context) {
  //return 
  Widget okButton = FlatButton(child: Text("OK"), onPressed: (){},
  );

  AlertDialog alert = AlertDialog(title: Text("Unable to connect to DB"), actions: [okButton,],
  );

  showDialog(context: context, builder:(BuildContext){ return alert;},);
}

void startShareLocation() {
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
