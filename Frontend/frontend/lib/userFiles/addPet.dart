import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend/friendsAndContacts/addContactPage.dart';
import 'package:frontend/mapFiles/temp.dart';
import 'package:frontend/userFiles/profile.dart';
import 'package:http/http.dart' as http;
import 'user.dart' as userlib;
import '../dog.dart';

class AddDog extends StatefulWidget {
  AddDog() : super();

  final String title = "Maps Demo";

  @override
  AddDogState createState() => AddDogState();
}

class AddDogState extends State<AddDog> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String breed = '';
  String age = '';
  String error = '';

  Widget _buildPageContent(BuildContext context) {
    return Container(
      color: colorLighterPink,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          CircleAvatar(
            child: Image.asset("logopurplepink.png"),
            maxRadius: 50,
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
            height: 20.0,
          ),
          _buildLoginForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FloatingActionButton(
                mini: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileEightPage()),
                  );
                },
                backgroundColor: colorPurple,
                child: Icon(Icons.arrow_back),
              )
            ],
          )
        ],
      ),
    );
  }

  Container _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
                height: 400,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 75.0,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Required field';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() => name = val);
                            },
                            style: TextStyle(color: colorPurple),
                            decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(color: colorPurple),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.person,
                                  color: colorPurple,
                                )),
                          )),
                      Container(
                        child: Divider(
                          color: colorPurple,
                        ),
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Required field';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() => breed = val);
                            },
                            style: TextStyle(color: colorPurple),
                            decoration: InputDecoration(
                                hintText: "Breed",
                                hintStyle: TextStyle(color: colorPurple),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.pets,
                                  color: colorPurple,
                                )),
                          )),
                      Container(
                        child: Divider(
                          color: colorPurple,
                        ),
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Required field';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() => age = val);
                            },
                            style: TextStyle(color: colorPurple),
                            decoration: InputDecoration(
                                hintText: "Age",
                                hintStyle: TextStyle(color: colorPurple),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: colorPurple,
                                )),
                          )),
                      Container(
                        child: Divider(
                          color: colorPurple,
                        ),
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: colorPurple,
                child: Icon(Icons.photo),
                foregroundColor: colorPeachPink,
              ),
            ],
          ),
          Container(
            height: 420,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    var url = 'https://group6-15.pvt.dsv.su.se/user/newdog';
                    var response = await http.post(Uri.parse(url), body: {
                      'name': name,
                      'breed': breed,
                      'age': age,
                      'weight': "0",
                      'uid': userlib.uid
                    });
                    if (response.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileEightPage()),
                      );
                    } else {
                      // ERROR MEDELANDE HÄR
                    }
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                child: Text("Add dog", style: TextStyle(color: colorPeachPink)),
                color: colorPurple,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(context),
    );
  }
}
