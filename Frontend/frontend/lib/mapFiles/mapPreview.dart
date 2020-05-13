import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/mapFiles/dialogsForMap.dart';
import 'package:frontend/routePickerMap/testDialog.dart';
import 'package:geojson/geojson.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class _MapPreviewPageState extends State<MapPreviewPage> {
  Location location;
  static LatLng latLng;

  DialogForMaps dialogForMap = new DialogForMaps();
  var estimatedTime;
  TestDialog testDia = new TestDialog();
  MapController mapController;
  StatefulMapController statefulMapController;
  StreamSubscription<StatefulMapControllerStateChange> sub;
  UserLocationOptions userLocationOptions;
  List<Marker> markers = [];

  var points = <LatLng>[];
  void loadData() async {
    print("Loading geojson data");
    var km = widget.km;
    var Postion = location;
    final data = await http.get("https://api.mapbox.com/directions/v5/mapbox/walking/18.064034,59.338738;18.073411113923477,59.332076081194614;18.071977555134517,59.34721459928733;18.064034,59.338738.json?access_token=pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A&steps=true&overview=full&geometries=geojson&annotations=distance&continue_straight=true");
    var jsonfile = json.decode(data.body);
    var routedata = jsonfile['routes'][0];
    var route = routedata["geometry"]["coordinates"];
    var distantsInMeter = routedata["geometry"]["distance"];
    estimatedTime = routedata["geometry"]["duration"]; // MAN KAN ÄNDRA GÅNGHASTIGHET FÖR ATT FÅ MER ACCURATE
    
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
    location = new Location();

    getLocation();

    
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
          ],
          ),
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
                  strokeWidth: 4.0,

                )
              ]
            ),
            
            userLocationOptions,
          ],
        ),
        Positioned(
          bottom: 1,
          right: 150,
        child: Row(
          children: <Widget>[
            Text(widget.km.toString() + "km"),
        Text("    Time:" + estimatedTime.toString()),
        Text(location.toString()),
        ],)
        ),
        // ...
      ])),
      appBar: AppBar(title: const Text('Route Preview'),
      actions: <Widget>[
        Text(widget.km.toString() + "km"),
        Text("Time:" + estimatedTime.toString()),
      ],),
    bottomNavigationBar: BottomAppBar(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon: Text('Cancel'), onPressed: () { Navigator.pop(context);},),
          IconButton(icon: Text('Saved Routes'), onPressed: () {},),
          IconButton(icon: Text('Save Route'), onPressed: () {
            dialogForMap.saveRoute(context);
          },),
          IconButton(icon: Text('Start Route'), onPressed: () {},),
        ],
      ),
    ),
    );
  }

  getLocation() async {
    var location = new Location();
    location.onLocationChanged().listen((currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      setState(() {
        latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
      });

      print("getLocation:$latLng");
    });
  }

  
}

class MapPreviewPage extends StatefulWidget {
  @override
  var km;
  MapPreviewPage ({Key key, this.km}) : super(key: key);
  _MapPreviewPageState createState() => _MapPreviewPageState();
}
