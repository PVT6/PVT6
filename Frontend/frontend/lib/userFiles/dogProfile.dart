import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/friendsAndContacts/friendsPage.dart';
import 'package:frontend/userFiles/profile.dart';
import '../dog.dart';
import 'user.dart' as userlib;
import 'addPet.dart';
import 'package:http/http.dart' as http;

class DogProfile extends StatefulWidget {
  Dog dog;

  DogProfile(Dog dog) : super() {
    this.dog = dog;
  }

  final String title = "Maps Demo";

//String name, String age, String weight, String breed
  @override
  DogProfileState createState() => DogProfileState(this.dog);
}

class DogProfileState extends State<DogProfile> {
  Dog dog;

  DogProfileState(Dog dog) {
    this.dog = dog;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: colorLighterPink,
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [colorPeachPink, colorPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                          height: double.infinity,
                          width: 380,
                          margin: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 10.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              //child:
                              //Image.asset("BrewDog.jpg", fit: BoxFit.cover),
                              child: widget.dog.dogPic != null
                                  ? (() {
                                      return FittedBox(
                                        child: widget.dog.dogPic,
                                        fit: BoxFit.cover,
                                      );

                              
                                    }())
                                  : Image.asset(
                                      "logopurplepink.png") //widget.dog.dogPic
                              )),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text(widget.dog.breed,
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.dog.name.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 280,
                  height: 80,
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Weight: ",
                          style: TextStyle(
                            color: colorPurple,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.dog.weight + "kg",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Height: ",
                          style: TextStyle(
                            color: colorPurple,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "50" + "cm",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          " Age: ",
                          style: TextStyle(
                            color: colorPurple,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.dog.age + "y.o",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                SizedBox(height: 10.0),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          color: colorPeachPink,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileEightPage()));
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                color: colorPurple,
                              ),
                              Text("Owners Profile",
                                  style: TextStyle(fontSize: 11)),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FlatButton(
                          color: colorPeachPink,
                          onPressed: () async {
                            var url =
                                'https://group6-15.pvt.dsv.su.se/dog/deletedog?id=${widget.dog.id.toString()}&uid=${userlib.uid}';

                            var response = await http.post(Uri.parse(url));

                            print(response.statusCode);
                            await getDogs();
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.cross,
                                color: colorPurple,
                              ),
                              Text("Remove Dog",
                                  style: TextStyle(fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
