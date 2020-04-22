import 'package:flutter/material.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';



class Mapbox extends StatefulWidget {
  @override
  _MapBoxState createState() => new _MapBoxState();
}

class _MapBoxState extends State<Mapbox> {
  MapController controller = new MapController();

 
  UserLocationOptions userLocationOptions;

  List<Marker> markers = [];

  

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
                context: context,
                mapController: controller,
                markers: markers,
                );
    return new Scaffold(
        appBar: new AppBar(title: new Text('Leaflet Maps')),
        body: new FlutterMap(
            mapController: controller,
            options: new MapOptions(center: LatLng(0,0), minZoom: 15.0,
             plugins: [
             // ADD THIS
              UserLocationPlugin(),
            ]
            ), //ändra detta till coordinate för att komma tillbaka till stockholm
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
              
            ]
            
            ));
  }
}
