import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geojson/geojson.dart';

import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class _MapPageState extends State<MapPage> {
  MapController mapController;
  StatefulMapController statefulMapController;
  StreamSubscription<StatefulMapControllerStateChange> sub;
  UserLocationOptions userLocationOptions;
  List<Marker> markers = [];

  var points = <LatLng>[];
  void loadData() async {
    print("Loading geojson data");
    final data = await http.get("https://api.mapbox.com/directions/v5/mapbox/walking/18.064034,59.338738;18.056411559317823,59.34593253503282;18.059948623152163,59.32885984909151;18.064034,59.338738.json?access_token=pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A&steps=true&overview=full&geometries=geojson&annotations=distance&continue_straight=true");
    var jsonfile = json.decode(data.body);
    var routedata = jsonfile['routes'][0];
    var route = routedata["geometry"]["coordinates"];
    
    for(var i = 0; i < route.length; i++){
      
  
        
        points.add(new LatLng(route[i][1], route[i][0]));
    }
    print(points);
    // Set<String> set = Set.from(route);
    // set.forEach((e) {
    //   print(e.runtimeType);
    //   var cord = e.toString().split(',');
    //   points.add(new LatLng(double.parse(cord[0]), double.parse(cord[1])));
    // });
   

    //await statefulMapController.fromGeoJson(geojson, verbose: true);
  }

  @override
  void initState() {
    mapController = MapController();
    statefulMapController = StatefulMapController(mapController: mapController);
    statefulMapController.onReady.then((_) => loadData());
    
    sub = statefulMapController.changeFeed.listen((change) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
      updateMapLocationOnPositionChange: false,
    );
    
    return Scaffold(
      body: SafeArea(
          child: Stack(children: <Widget>[
        FlutterMap(
          mapController: mapController,
          options:
          
              new MapOptions(center: LatLng(59.338738, 18.064034), minZoom: 15.0, plugins: [
            // ADD THIS
            UserLocationPlugin(),
          ]),
          layers: [
            new TileLayerOptions(
                urlTemplate: FlutterConfig.get('MAPBOXAPI_URL'),
                additionalOptions: {
                  'accessToken': FlutterConfig.get('MAPBOX_ID'),
                  'id': 'Streets-copy'
                }),

            // ADD THIS
            
            new PolylineLayerOptions(
              polylines:[
                new Polyline(
                  points: points,
                  color: Colors.blue,
                  strokeWidth: 5.0,

                )
              ]
            ),
            userLocationOptions,
          ],
        ),
        // ...
      ])),
    );
  }

  
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}
