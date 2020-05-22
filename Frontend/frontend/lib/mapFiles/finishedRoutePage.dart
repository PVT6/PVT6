import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/friendsAndContacts/friendsPage.dart';
import 'package:frontend/userFiles/profile.dart';



class FinishedRoutePage extends StatefulWidget {
  

  FinishedRoutePage() : super() ;

  final String title = "Maps Demo";

//String name, String age, String weight, String breed
  @override
  FinishedRoutePageState createState() => FinishedRoutePageState();
}

class FinishedRoutePageState extends State<FinishedRoutePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileEightPage()),
          ),
        ),
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
                            child:
                                Image.asset("BrewDog.jpg", fit: BoxFit.cover),
                            // child: dogPicture == null
                            //     ? Image.asset("logopurplepink.png")
                            //     : Image.file(
                            //         File(
                            //           dogPicture,
                            //         ),
                            //         fit: BoxFit.cover,
                            //       )),
                          )),
                      
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Hej",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
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
                          onPressed: () {},
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileEightPage()));
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