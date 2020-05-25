import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_config/flutter_config.dart';


import 'mapPreview.dart';

class MapWithRoute extends StatefulWidget {
  @override
  var pointsImport;
  var latLngImport;
  MapWithRoute ({Key key, this.pointsImport, this.latLngImport}) : super(key: key);
  _MapWithRoute createState() => _MapWithRoute();
}

class _MapWithRoute extends State<MapWithRoute> {
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
          
              new MapOptions(center: LatLng(latLng.latitude, latLng.longitude), minZoom: 15.0, plugins: [
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
        
        // ...
      ])),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapPreviewPage(),
                  ));
                     },
                  icon: Icon(Icons.router),
                  label: Text('Go To Routes'),
                  foregroundColor: Colors.pink,
                  backgroundColor: Colors.purple
        ),
    );
  }
  
}