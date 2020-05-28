import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/auth.dart';

import 'mapFiles/mapsDemo.dart';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:frontend/userFiles/user.dart' as userlib;



const colorBeige = const Color(0xFFF5F3EE);
const colorDarkBeige = const Color(0xFFc2c0bc);
const colorPrimaryRed = const Color(0xffEA9999);
const colorLightRed = const Color(0xFFffcaca);
const colorDarkRed = const Color(0xffb66a6b);
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

class LoadingScreen extends StatefulWidget {

  FirebaseUser user;
  LoadingScreen({Key key, this.user}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final AuthService _auth = AuthService();
  LatLng userLocation;
  @override
  void initState() {

    loaddUsersData();
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: colorBeige,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 170),
              SizedBox(
                        width: 280,
                        height: 200,
                        child: Image.asset(
                          'assets/logoprotonotext.png',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text("Hang in there, more dog-fun will soon be available!",
                        style: style.copyWith(color: colorDarkRed, fontSize: 15.0,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,)

            ])
                ),
                ),
                Expanded(flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(colorDarkRed),),
                  Padding(padding: EdgeInsets.only(top: 20.0),),
                  Text("Loading data...", style: style.copyWith(color: colorDarkRed, fontWeight: FontWeight.bold),),
                  SizedBox(height: 120,)
                ],
                ),
                )

          ])
        ],
      ),

      
      
    );

  }


  loaddUsersData() async{
        FirebaseUser user = widget.user;
        await _auth.connectLoggedInUser(user);
        await getLocation();
        Navigator.pop(context);
        Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => MapsDemo()));
      }



       getLocation() async {
    var location = new Location();
    location.onLocationChanged().listen((currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      setState(() {
        userLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
        userlib.setUserLocation(userLocation);
      });

      print("getLocation:$userLocation");
    });
  }

}