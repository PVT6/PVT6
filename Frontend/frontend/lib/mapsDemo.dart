import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/MySignInPage.dart';
import 'package:frontend/locationMapTest.dart';

import 'package:flutter/cupertino.dart';
import 'package:frontend/main.dart';
import 'package:frontend/profile.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/temp.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'contacts.dart';
import 'settings.dart';
import 'locationMapTest.dart';

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
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: controller,
      markers: markers,
    );
    return MaterialApp(
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
        // floatingActionButton: FloatingActionButton.extended(
        //   elevation: 4.0,
        //   icon: const Icon(Icons.add),
        //   label: const Text('Create new route'),
        //   backgroundColor: Colors.blue,
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => MapSample()),
        //     );
        //   },
        // ),
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
                          "https://api.mapbox.com/styles/v1/lucas-domeij/ck9b3kgpp096a1iqs11f9jnji/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A",
                      additionalOptions: {
                        'accessToken':
                            'pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A',
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
                accountName: Text("Jakob Ödman"),
                accountEmail: Text("fakeMail123@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  child: Text(
                    "PH", //placeholder, kanske användarbild här? ändra då text till backgroundimage(user.getImage)
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
                                builder: (context) => Settings()))
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
