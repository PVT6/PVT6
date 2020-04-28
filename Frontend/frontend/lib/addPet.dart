import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:frontend/profile.dart';
import 'package:numberpicker/numberpicker.dart';
import 'user.dart' as userlib;
import 'package:http/http.dart' as http;

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
      color: Colors.blue.shade100,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          CircleAvatar(
            child: Image.asset("DogLogo.png"),
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
                  Navigator.pop(context);
                },
                backgroundColor: Colors.blue,
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
                        height: 90.0,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            onChanged: (val) {
                              setState(() => name = val);
                            },
                            style: TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle:
                                    TextStyle(color: Colors.blue.shade200),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                )),
                          )),
                      Container(
                        child: Divider(
                          color: Colors.blue.shade400,
                        ),
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            onChanged: (val) {
                              setState(() => breed = val);
                            },
                            style: TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                                hintText: "Breed",
                                hintStyle:
                                    TextStyle(color: Colors.blue.shade200),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.pets,
                                  color: Colors.blue,
                                )),
                          )),
                      Container(
                        child: Divider(
                          color: Colors.blue.shade400,
                        ),
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            onChanged: (val) {
                              setState(() => age = val);
                            },
                            style: TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                                hintText: "Age",
                                hintStyle:
                                    TextStyle(color: Colors.blue.shade200),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.blue,
                                )),
                          )),
                      Container(
                        child: Divider(
                          color: Colors.blue.shade400,
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
                backgroundColor: Colors.blue.shade600,
                child: Icon(Icons.photo),
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
                         var url = 'https://group6-15.pvt.dsv.su.se/user/${userlib.uid}/newdog';
                         var response = await http.post(Uri.parse(url),  body: {'name': name, 'breed': breed, 'age': age, 'weight': "0" });
                         if (response.statusCode == 200){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileEightPage()),
                          );
                         } 
                         else {

                         }
                        
                      
                    }
                  },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                child: Text("Add dog", style: TextStyle(color: Colors.white70)),
                color: Colors.blue,
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
