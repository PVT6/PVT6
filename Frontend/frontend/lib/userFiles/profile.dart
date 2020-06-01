import 'dart:convert';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/loadingScreen.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:frontend/mapFiles/temp.dart';
import 'package:frontend/routePickerMap/Route.dart';
import 'package:frontend/userFiles/addDogTest.dart';
import 'package:frontend/userFiles/dogProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/userFiles/editProfile.dart';

import 'user.dart' as userlib;
import 'package:frontend/mapFiles/mapsDemo.dart';
import 'package:http/http.dart' as http;
import '../dog.dart';
import 'package:latlong/latlong.dart' as latlng;
import 'package:geocoder/geocoder.dart';

List<Dog> userDogs;
List<SavedRoute> savedRoutes = [];

const _colorBeige = const Color(0xFFF5F3EE);
const _colorDarkBeige = const Color(0xFFc2c0bc);
const _colorPrimaryRed = const Color(0xffEA9999);
const _colorLightRed = const Color(0xFFffcaca);
const _colorDarkRed = const Color(0xffb66a6b);

class ProfileEightPage extends StatefulWidget {
  ProfileEightPage() : super();
  @override
  ProfileEightPageState createState() => ProfileEightPageState();
}

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

class ProfileEightPageState extends State<ProfileEightPage> {
  latlng.LatLng setter = latlng.LatLng(0, 0);
  @override
  void initState() {
    super.initState();
    setDogs();
    getSavedRoutes();
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

  Future<void> getSavedRoutes() async {
    final response = await http.get(
        "https://group6-15.pvt.dsv.su.se/route/getSavedRoutes?uid=${userlib.uid}");
    if (response.statusCode == 200) {
      savedRoutes = (json.decode(response.body) as List)
          .map((i) => SavedRoute.fromJson(i))
          .toList();
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
      backgroundColor: _colorBeige,
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
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    userlib.name,
                    style: style.copyWith(
                        fontSize: 25.0,
                        color: colorDarkRed,
                        fontWeight: FontWeight.bold),
                  ),
                )),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: _colorLightRed,
                    elevation: 15,
                    child: Row(children: <Widget>[
                      Icon(
                        Icons.edit,
                        color: _colorDarkRed,
                      ),
                      Text("Edit Profile")
                    ]),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                  ),
                  RaisedButton(
                    color: _colorLightRed,
                    elevation: 15,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.pets,
                          color: _colorDarkRed,
                        ),
                        Text("Add Dog")
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InputPage()),
                      );
                    },
                  ),
                ]),
            UserInfo(),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatefulWidget {
  UserInfo() : super();
  @override
  UserInfoState createState() => UserInfoState();
}

class UserInfoState extends State<UserInfo> {
  getLocationName() async {
    final coordinates1 = new Coordinates(userlib.usersCurrentLocation.latitude,
        userlib.usersCurrentLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates1);
    var first = addresses.first;
    return addresses.first.addressLine;
  }

  showDogList(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: colorBeige,
              title: Text(
                "My Dogs",
                style: style.copyWith(
                  fontSize: 28,
                ),
              ),
              content: Row(
                children: <Widget>[
                  Container(
                    height: 300,
                    width: 250,
                    child: new ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: userDogs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Dog c = userDogs?.elementAt(index);
                          return Row(
                            children: <Widget>[
                              Container(
                                height: 75,
                                width: 175,
                                margin: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 3.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          20.0) //         <--- border radius here
                                      ),
                                  image: DecorationImage(
                                    image: AssetImage("routeBackground.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Center(
                                    child: Card(
                                  child: Text(
                                    '${userDogs[index].name} ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                )),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
              actions: <Widget>[
                RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.red,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: style.copyWith(fontSize: 13),
                    )),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Row(
              children: <Widget>[
                Text(
                  "My Dogs",
                  style: style.copyWith(
                    color: _colorDarkRed,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDogList(context);
                  },
                )
              ],
            ),
          ),
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
                        child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                _colorDarkRed)),
                      ),
              )),
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Row(
              children: <Widget>[
                Text(
                  "My Saved Routes",
                  style: style.copyWith(
                    color: _colorDarkRed,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    //showDogList(context);
                  },
                )
              ],
            ),
          ),
          SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                height: 70,
                child: userDogs != null
                    ? ListView.builder(
                        //https://pusher.com/tutorials/flutter-listviews

                        shrinkWrap: true,
                        itemCount: savedRoutes?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          SavedRoute c = savedRoutes?.elementAt(index);
                          return (c.name != null && c.name.length > 0)
                              ? SizedBox(
                                  child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    
                                    width: 75,
                                    height: 75,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Icon(Icons.directions_walk)
                                    ),
                                  ),
                                ))
                              : SizedBox(
                                  child: InkWell(
                                  onTap: () {},
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
                        child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                _colorDarkRed)),
                      ),
              )),
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information", //userData
              style: style.copyWith(
                  color: _colorDarkRed, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
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
                                Icon(Icons.my_location, color: _colorDarkRed),
                            title: Text(
                              "Location",
                              style: TextStyle(color: _colorDarkRed),
                            ),
                            subtitle: FutureBuilder<dynamic>(
                              future: getLocationName(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data,
                                    style: TextStyle(color: _colorDarkRed),
                                  );
                                } else {
                                  return Text(
                                    "Loading",
                                    style: TextStyle(color: _colorDarkRed),
                                  );
                                }
                              },
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.email, color: _colorDarkRed),
                            title: Text(
                              "Email",
                              style: TextStyle(color: _colorDarkRed),
                            ),
                            subtitle: Text(
                              userlib.email,
                              style: TextStyle(color: _colorDarkRed),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone, color: _colorDarkRed),
                            title: Text(
                              "Phone",
                              style: TextStyle(color: _colorDarkRed),
                            ),
                            subtitle: Text(
                              userlib.phone,
                              style: TextStyle(color: _colorDarkRed),
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

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const ProfileHeader(
      {Key key,
      @required this.coverImage,
      @required this.avatar,
      @required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 60,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key key,
      @required this.image,
      this.borderColor = _colorDarkRed,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: _colorDarkRed,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
        ),
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
