import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/dog.dart';
import 'package:frontend/dogsNearMe.dart';
import 'package:frontend/profile.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/temp2.dart';
import 'user.dart' as userlib;
import 'package:flutter_config/flutter_config.dart';

import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';


import 'MySignInPage.dart';
import 'browseDogParks.dart';
import 'contacts.dart';
import 'settings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

MapController controller = new MapController();
List<Dog> dogs;
List<Dog> userDogs;


//const kApiKey =
    //'pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A';

class Mapbox extends StatefulWidget {
  final LatLng coordinates;

  Mapbox(this.coordinates);
  @override
  _MapBoxState createState() => new _MapBoxState();
}

class _MapBoxState extends State<Mapbox> {
  final AuthService _auth = AuthService();
  LatLng userLocation;

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
    userLocationOptions = UserLocationOptions(
        context: context,
        mapController: controller,
        onLocationUpdate: (LatLng pos) => userLocation = pos,
        updateMapLocationOnPositionChange: false,
        zoomToCurrentLocationOnLoad: false,
        markers: markers,
        defaultZoom: 30.0);
    return new Scaffold(
      appBar: new AppBar(title: new Text('Dog App')),
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
                  "PH", //userData
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            CustomListTile(
                Icons.person,
                'My Dog Profile',
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
                Icons.pets,
                'Dogs Near Me',
                () => {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => DogsNearMe()))
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
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Search'),
        icon: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
        FlutterMap(
            mapController: controller,
            options:
                new MapOptions(center: widget.coordinates, minZoom: 15.0, plugins: [
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
              MarkerLayerOptions(markers: [
                new Marker(
                    width: 45.0,
                    height: 45.0,
                    point: widget.coordinates,
                    builder: (context) => new Container(
                          child: IconButton(
                            icon: Icon(Icons.pets),
                            color: Colors.red,
                            iconSize: 45.0,
                            onPressed: () {
                              print('Marker tapped');
                            },
                          ),
                        )),
                new Marker(
                    width: 45.0,
                    height: 45.0,
                    point: userLocation,
                    builder: (context) => new Container(
                          child: IconButton(
                            icon: Icon(Icons.person),
                            color: Colors.red,
                            iconSize: 45.0,
                            onPressed: () {
                              print('Marker tapped');
                            },
                          ),
                        )),
              ]),
              // ADD THIS
              userLocationOptions,
            ]),
            Column(children: <Widget>[],)
      ]),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        bottom: false,
        child: MapBoxPlaceSearchWidget(
          popOnSelect: true,
          apiKey: FlutterConfig.get('MAPBOX_ID'),
          searchHint: 'Search around',
          limit: 10,
          onSelected: (place) {
            LatLng pos = new LatLng(
                place.geometry.coordinates[1], place.geometry.coordinates[0]);
            controller.move(pos, 15.0);
          },
          context: context,
        ),
      ),
    );
  }
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
