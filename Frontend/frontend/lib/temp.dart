import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/profile.dart';
import 'package:frontend/services/auth.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'MySignInPage.dart';
import 'contacts.dart';
import 'mapsDemo.dart';
import 'settings.dart';

MapController controller = new MapController();

const kApiKey =
    'pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A';

class Mapbox extends StatefulWidget {
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
        onLocationUpdate: (LatLng pos) =>
            userLocation = pos,
        updateMapLocationOnPositionChange: false,
        zoomToCurrentLocationOnLoad: true,
        markers: markers,
        defaultZoom: 16.0);
    return new Scaffold(
      appBar: new AppBar(title: new Text('Dog App')),
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
      body: new FlutterMap(
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
          apiKey: kApiKey,
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
