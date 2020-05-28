import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/auth.dart';

import 'mapFiles/mapsDemo.dart';


const colorBeige = const Color(0xFFF5F3EE);
const colorDarkBeige = const Color(0xFFc2c0bc);
const colorPrimaryRed = const Color(0xffEA9999);
const colorLightRed = const Color(0xFFffcaca);
const colorDarkRed = const Color(0xffb66a6b);

class LoadingScreen extends StatefulWidget {

  FirebaseUser user;
  LoadingScreen({Key key, this.user}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final AuthService _auth = AuthService();

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
            decoration: BoxDecoration(color: colorDarkBeige,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                        width: 280,
                        height: 200,
                        child: Image.asset(
                          'assets/logopurplepink.png',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text("Dog Walk",
                        style: TextStyle(color: colorLightRed),)

            ])
                ),
                ),
                Expanded(flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(padding: EdgeInsets.only(top: 20.0),),
                  Text("Loading Data...", style: TextStyle(color: colorLightRed),)
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
        Navigator.pop(context);
        Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => MapsDemo()));
      }

}