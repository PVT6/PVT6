import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:frontend/friendsAndContacts/friendsPage.dart';
import 'package:frontend/routePickerMap/Route.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/userFiles/user.dart' as userlib;
import 'dart:convert';






class MapWithRoute extends StatefulWidget {
  @override
  var pointsImport;
  var latLngImport;
  MapWithRoute ({Key key, this.pointsImport, this.latLngImport}) : super(key: key);
  _MapWithRoute createState() => _MapWithRoute();
}

class _MapWithRoute extends State<MapWithRoute> {
  LatLng usersCurrentPos;
  MapController mapController;
  StatefulMapController statefulMapController;
  StreamSubscription<StatefulMapControllerStateChange> sub;
  UserLocationOptions userLocationOptions;
  List<Marker> markers = [];
  @override
  void initState() {
    mapController = MapController();
    statefulMapController = StatefulMapController(mapController: mapController);
    sub = statefulMapController.changeFeed.listen((change) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var points = widget.pointsImport;
    LatLng latLng = widget.latLngImport;
    usersCurrentPos = latLng;
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
      onLocationUpdate: (LatLng pos) => usersCurrentPos = pos,
      updateMapLocationOnPositionChange: true,
    );
    
    return Scaffold(
      body: SafeArea(
          child: Stack(children: <Widget>[
        FlutterMap(
          mapController: mapController,
          options:
          
              new MapOptions(center: LatLng(latLng.latitude, latLng.longitude), minZoom: 17.0, plugins: [
            // ADD THIS
            UserLocationPlugin(),
          ],
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate: FlutterConfig.get('MAPBOXAPI_URL'),
                additionalOptions: {
                  'accessToken': FlutterConfig.get('MAPBOX_ID'),
                  'id': 'Streets-copy'
                }),
            MarkerLayerOptions(markers: markers),
            // ADD THIS

            new PolylineLayerOptions(polylines: [
              new Polyline(
                points: points,
                color: Colors.blue,
                strokeWidth: 4.0,
              )
            ]),

            userLocationOptions,
          ],
        ),

        
        // ...
      ])),
        appBar: AppBar(
        title: const Text('Route Walker'),
        backgroundColor: colorPurple,
      ),
        




                              floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
                  Navigator.pop(context);
                     },
                  icon: Icon(FontAwesomeIcons.flagCheckered,
                            color: colorPurple,),
                  label: Text("Finish", style: TextStyle(fontSize: 11, color: colorPurple), ),
                  backgroundColor: colorPeachPink,
        ),





                              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  getLocation() async {
    var location = new Location();
    location.onLocationChanged.listen((currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      setState(() {
        usersCurrentPos = LatLng(currentLocation.latitude, currentLocation.longitude);
      });

      print("getLocation:$usersCurrentPos");
    });
  
}



}