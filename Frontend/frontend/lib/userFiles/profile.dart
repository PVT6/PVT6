import 'dart:convert';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/mapFiles/temp.dart';
import 'package:frontend/userFiles/addDogTest.dart';
import 'package:frontend/userFiles/dogProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/userFiles/editProfile.dart';

import 'user.dart' as userlib;
import 'package:frontend/mapFiles/mapsDemo.dart';
import 'package:http/http.dart' as http;
import '../dog.dart';
import 'package:latlong/latlong.dart' as latlng;

List<Dog> userDogs;

class ProfileEightPage extends StatefulWidget {
  ProfileEightPage() : super();

  @override
  ProfileEightPageState createState() => ProfileEightPageState();
}

class ProfileEightPageState extends State<ProfileEightPage> {
  latlng.LatLng setter = latlng.LatLng(0,0);
  @override
  void initState() {
    super.initState();
    setDogs();
  }

  Future<void> getDogs() async {
    var uid = userlib.uid;
    var url = 'https://group6-15.pvt.dsv.su.se/user/dogs?uid=${uid}';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      dogs = (json.decode(response.body) as List)
          .map((i) => Dog.fromJson(i))
          .toList();
      setState(() {
        userDogs = dogs;
      });
    } else {
      // ERROR HÄR
    }
  }

  Future<void> setDogs() async {
    getDogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLighterPink,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: //Row med items
            MaterialButton(
          shape: CircleBorder(),
          elevation: 0,
          child: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapsDemo(setter)),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  child: Hero(
                    tag: "BrewDog.jpg",
                    child: ClipShadowPath(
                      clipper: CircularClipper(),
                      shadow: Shadow(blurRadius: 20.0),
                      child: Image(
                        height: 400.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: AssetImage("BrewDog.jpg"),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.only(left: 30.0),
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                    ),
                    IconButton(
                      padding: EdgeInsets.only(left: 30.0),
                      onPressed: () => print('Add to Favorites'),
                      icon: Icon(Icons.favorite_border),
                      iconSize: 30.0,
                      color: Colors.black,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0.0,
                  left: 20.0,
                  child: MaterialButton(
                    color: colorPeachPink,
                    shape: CircleBorder(),
                    elevation: 0,
                    child: Icon(
                      Icons.edit,
                      color: colorPurple,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 25.0,
                  child: MaterialButton(
                    color: colorPeachPink,
                    elevation: 0,
                    child: Row(
                      children: <Widget>[
                        Text("Add pet"),
                        Icon(
                          Icons.pets,
                          color: colorPurple,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InputPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            UserInfo(),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
              alignment: Alignment.topLeft,
              child: BorderedText(
                strokeWidth: 5.0,
                strokeColor: colorPurple,
                child: Text(
                  "My Dogs",
                  style: TextStyle(
                    color: colorLighterPink,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
              )),
          SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                height: 70,
                child: userDogs != null
                    ? ListView.builder(
                        //https://pusher.com/tutorials/flutter-listviews

                        shrinkWrap: true,
                        itemCount: userDogs?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          Dog c = userDogs?.elementAt(index);
                          return (c.name != null && c.name.length > 0)
                              ? SizedBox(
                                  child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DogProfile(c)),
                                    );
                                  },
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.asset(
                                        'BrewDog.jpg',
                                      ),
                                    ),
                                  ),
                                ))
                              : SizedBox(
                                  child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DogProfile(c)),
                                    );
                                  },
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.asset(
                                        'BrewDog.jpg',
                                      ),
                                    ),
                                  ),
                                ));
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              )),
          Container(
              padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
              alignment: Alignment.topLeft,
              child: BorderedText(
                strokeWidth: 6.0,
                strokeColor: colorPurple,
                child: Text(
                  "User Information", //userData
                  style: TextStyle(
                    color: colorLighterPink,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
              )),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading:
                                Icon(FontAwesomeIcons.user, color: colorPurple),
                            title: Text(
                              "Username",
                              style: TextStyle(color: colorPurple),
                            ),
                            subtitle: Text(
                              userlib.name,
                              style: TextStyle(color: colorPurple),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.email, color: colorPurple),
                            title: Text(
                              "Email",
                              style: TextStyle(color: colorPurple),
                            ),
                            subtitle: Text(
                              userlib.email,
                              style: TextStyle(color: colorPurple),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone, color: colorPurple),
                            title: Text(
                              "Phone",
                              style: TextStyle(color: colorPurple),
                            ),
                            subtitle: Text(
                              userlib.phone,
                              style: TextStyle(color: colorPurple),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - size.width / 4,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  ClipShadowPath({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
