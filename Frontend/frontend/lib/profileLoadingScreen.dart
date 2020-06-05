
import 'package:flutter/material.dart';
import 'package:frontend/routePickerMap/Route.dart';

import 'dog.dart';

import 'package:http/http.dart' as http;

import 'package:frontend/userFiles/user.dart' as userlib;
import 'dart:convert';
import 'package:frontend/userFiles/profile.dart';

const _colorBeige = const Color(0xFFF5F3EE);
const _colorDarkRed = const Color(0xffb66a6b);
TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

class ProfileLoadingScreen extends StatefulWidget {
  ProfileLoadingScreen() : super();

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<ProfileLoadingScreen> {
  @override
  void initState() {
    loaddUsersData();
    setPictures();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: _colorBeige,
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                  child: Column(
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
                    Text(
                      "Hang in there, more dog-fun will soon be available!",
                      style: style.copyWith(
                          color: _colorDarkRed,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ])),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(_colorDarkRed),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text(
                    "Loading data...",
                    style: style.copyWith(
                        color: _colorDarkRed, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 120,
                  )
                ],
              ),
            )
          ])
        ],
      ),
    );
  }

  Future<void> loaddUsersData() async {
    await setPictures();

    Navigator.pop(context);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfileEightPage()));
  }

  Future<void> getDogs() async {
    var uid = userlib.uid;
    var url = 'https://group6-15.pvt.dsv.su.se/user/dogs?uid=${uid}';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        userDogs = (json.decode(response.body) as List)
            .map((i) => Dog.fromJson(i))
            .toList();
      });
    } else {
      // ERROR HÄR
    }
  }

  Future<Image> getPicture(Dog d) async {
    Image temp;
    await d.getPicture();
    setState(() {
      temp = d.dogPic;
    });
    return temp;
  }

  Future setPictures() async {
    await getDogs();
    userDogs.forEach((element) {
      _asyncMethod(element);
    });
  }

  Future _asyncMethod(Dog d) async {
    await d.getPicture();
    print("ger");
  }

  Future<void> getSavedRoutes() async {
    final response = await http.get(
        "https://group6-15.pvt.dsv.su.se/route/getSavedRoutes?uid=${userlib.uid}");
    if (response.statusCode == 200) {
      setState(() {
        savedRoutes = (json.decode(response.body) as List)
            .map((i) => SavedRoute.fromJson(i))
            .toList();
      });
    } else {
      // ERROR HÄR
    }
  }
}
