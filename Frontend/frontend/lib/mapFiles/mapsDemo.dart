import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/browseDogParks.dart';
import 'package:frontend/friendsAndContacts/contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
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


MapController controller = new MapController();


class MapsDemo extends StatefulWidget {
  MapsDemo() : super();

  final String title = "Maps Demo";

  @override
  MapsDemoState createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
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
      backgroundColor: Colors.blue,
      child: Icon(
        icon,
        size: 36.0,
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
    return new MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.pin_drop),
              title: new Text('Explore'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Commute'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Stack(
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
                      urlTemplate:
                          FlutterConfig.get('MAPBOXAPI_URL'),
                      additionalOptions: {
                        'accessToken':
                            FlutterConfig.get('MAPBOX_ID'),
                        'id': 'Streets-copy'
                      }),
                  MarkerLayerOptions(markers: markers),
                  // ADD THIS
                  userLocationOptions,
                ]),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    button(_onMapTypeButtonPressed, Icons.map),
                    SizedBox(
                      height: 16.0,
                    ),
                    button(_onAddMarkerButtonPressed, Icons.add_location),
                    SizedBox(
                      height: 16.0,
                    ),
                    button(_goToPosition1, Icons.location_searching),
                  ],
                ),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          title: Text("SafeLight Stockholm"),
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
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
                      color: Colors.white, fontSize: 16.0, letterSpacing: 1.1),
                ),
                currentAccountPicture: CircleAvatar(
                  child: Text(
                    "PH", //userData (om vi vill ha profilbild)
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
                  'Contacts',
                  () => {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Contacts()))
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
                  Icons.local_florist,
                  'Browse Dogparks',
                  () => {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => BrowseDogParks()))
                      }),
              CustomListTile(
                  Icons.lock,
                  'Log out',
                  () async => {
                        await _auth.signOut(),
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => MySignInPage()))
                      }),
            ],
          ),
        ),
      ),
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
