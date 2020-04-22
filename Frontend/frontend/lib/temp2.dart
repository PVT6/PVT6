import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Mapbox extends StatefulWidget {
  @override
  _MapBoxState createState() => new _MapBoxState();
}
 
class _MapBoxState extends State<Mapbox> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text('Leaflet Maps')),
        body: new FlutterMap(
            options: new MapOptions(
                center: new LatLng(40.71, -74.00), minZoom: 10.0),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/lucas-domeij/ck9b3kgpp096a1iqs11f9jnji/tiles/256/%7Bz%7D/%7Bx%7D/%7By%7D@2x?access_token=pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A",
                  additionalOptions: {
                    'accessToken':'pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A',
                    'id': 'mapbox.mapbox_street-v7'
                  }
                  ),
              new MarkerLayerOptions(markers: [
                new Marker(
                    width: 45.0,
                    height: 45.0,
                    point: new LatLng(40.73, -74.00),
                    builder: (context) => new Container(
                          child: IconButton(
                            icon: Icon(Icons.location_on),
                            color: Colors.red,
                            iconSize: 45.0,
                            onPressed: () {
                              print('Marker tapped');
                            },
                          ),
                        ))
              ])
            ]));
  }
}
