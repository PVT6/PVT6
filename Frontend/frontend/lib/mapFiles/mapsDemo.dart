import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/browseDogParks.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/friendsAndContacts/friendsPage.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:frontend/mapFiles/mapBoxSearch.dart';
import 'package:frontend/mapFiles/temp.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/settings.dart';
import 'package:frontend/userFiles/user.dart' as userlib;
import 'package:frontend/userFiles/profile.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import '../dog.dart';



// Färgschema #1
const colorPurple = const Color(0xFF82658f);
const colorPeachPink = const Color(0xFFffdcd2);
const colorLighterPink = const Color(0xFFffe9e5);

class MapsDemo extends StatefulWidget {
  MapsDemo() : super();

  final String title = "Maps Demo";

  @override
  MapsDemoState createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
  MapController controller = new MapController();
  final AuthService _auth = AuthService();
  UserLocationOptions userLocationOptions;

  List<Marker> markers = [];

  String _randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  Future<void> getDogs() async {
    var uid = userlib.uid;
    var url = 'https://group6-15.pvt.dsv.su.se/user/dogs?uid=${uid}';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      dogs = (json.decode(response.body) as List)
          .map((i) => Dog.fromJson(i))
          .toList();
      userDogs = dogs;
    } else {
      // ERROR HÄR
    }
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      heroTag: _randomString(10),
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: colorPeachPink,
      child: Icon(
        icon,
        size: 36.0,
        color: colorPurple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getDogs();
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: controller,
      markers: markers,
      updateMapLocationOnPositionChange: false,
    );
    return Scaffold(
      drawer: Drawer(
        child: Container(
            color: colorLighterPink,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: colorPurple),
                  accountName: Text(
                    userlib.name, //userData
                    style: TextStyle(
                        color: textYellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        letterSpacing: 1.1),
                  ),
                  accountEmail: Text(
                    userlib.email, //userData
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1.1),
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: Text(
                      "PH", //userData
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                CustomListTile(
                    Icons.person,
                    'Profile',
                    () => {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => ProfileEightPage()))
                        }),
                CustomListTile(
                    Icons.contact_phone,
                    'Connections',
                    () => {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => FriendsPage()))
                        }),
                CustomListTile(
                    Icons.settings,
                    'Settings',
                    () => {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => Settings()))
                        }),
                CustomListTile(
                    FontAwesomeIcons.dog,
                    'Browse Dogfriendly Places',
                    () => {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => BrowseDogParks()))
                        }), //Tror denna kan behövs senare då logout antagligen är fel implementerad
                // CustomListTile(
                //     Icons.lock,
                //     'Log out',
                //     () async => {
                //           await _auth.signOut(),
                //           Navigator.push(
                //               context,
                //               new MaterialPageRoute(
                //                   builder: (context) => MySignInPage()))
                //         }),
                SizedBox(
                  height: 220,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      height: 120,
                      child: Image.asset(
                        'assets/logopurplepink.png',
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Material(
                      elevation: 5.0,
                      color: Colors.red,
                      child: MaterialButton(
                        minWidth: 120,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      MySignInPage())); // dismiss dialog
                        },
                        child: Text("Sign out",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
      body: Builder(builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            FlutterMap(
                mapController: controller,
                options:
                    new MapOptions(center: LatLng(0, 0), minZoom: 15.0, plugins: [
                  // ADD THIS
                  UserLocationPlugin(),
                ]), //ändra detta till coordinate för att komma tillbaka till stockholm
                layers: [
                  new TileLayerOptions(
                      urlTemplate: FlutterConfig.get('MAPBOXAPI_URL'),
                      additionalOptions: {
                        'accessToken': FlutterConfig.get('MAPBOX_ID'),
                        'id': 'mapbox.mapbox-streets-v8'
                      }),
                  MarkerLayerOptions(markers: markers),
                  // ADD THIS
                  userLocationOptions,
                ]),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    button(_onMapTypeButtonPressed, FontAwesomeIcons.dice),
                    SizedBox(
                      height: 16.0,
                    ),
                    button(
                        _onAddMarkerButtonPressed, FontAwesomeIcons.directions),
                    SizedBox(
                      height: 16.0,
                    ),
                    button(_goToPosition1, Icons.photo_camera),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: colorPurple,
                        size: 50,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          
                          Text(
                            "Search Around",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 160,),
                          Icon(Icons.search),
                        ],
                      ),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchLocation(controller: controller,),
            ),
          );
                      },
                    ),
                    Row(children: <Widget>[

                    ],),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  _onMapTypeButtonPressed() {}

  _onAddMarkerButtonPressed() {}

  _goToPosition1() {}
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: onTap,
            child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Text(
                          text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ))),
      ),
    );
  }
}

