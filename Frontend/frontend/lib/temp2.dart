
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocation/geolocation.dart';

class Mapbox extends StatefulWidget {
  @override
  _MapBoxState createState() => new _MapBoxState();
}

class _MapBoxState extends State<Mapbox> {
  MapController controller = new MapController();

  getPermission() async {
    final GeolocationResult result =
        await Geolocation.requestLocationPermission(
            permission: const LocationPermission(
                android: LocationPermissionAndroid.fine,
                ios: LocationPermissionIOS.always));
    return result;
  }

  getLocation() {
    return getPermission().then((result) async {
      if (result.isSucessful) {
        final coords =
            await Geolocation.currentLocation(accuracy: LocationAccuracy.best);
      }
    });
  }

  buildMap() {
    getLocation().then((response) {
      if (response.isSuccessful) {
        response.listen((value) {
          controller.move(
              new LatLng(value.location.latitude, value.location.longitude),
              15.0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text('Leaflet Maps')),
        body: new FlutterMap(
<<<<<<< HEAD
            options: new MapOptions(
                center: new LatLng(59.334591, 18.063240), minZoom: 16.0),
=======
            mapController: controller,
            options: new MapOptions(center: buildMap(), minZoom: 15.0), //ändra detta till coordinate för att komma tillbaka till stockholm
>>>>>>> 3cfbe65a75f7ab8bceda7d498bd755361848c0a8
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/lucas-domeij/ck9b3kgpp096a1iqs11f9jnji/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A',
                    'id': 'Streets-copy'
                  }),
              new MarkerLayerOptions(markers: [
                new Marker(
                    // width: 45.0,
                    // height: 45.0,
                    // point: new LatLng(40.73, -74.00),
                    // builder: (context) => new Container(
                    //       child: IconButton(
                    //         icon: Icon(Icons.location_on),
                    //         color: Colors.red,
                    //         iconSize: 45.0,
                    //         onPressed: () {
                    //           print('Marker tapped');
                    //         },
                    //       ),
                    )
              ])
            ]));
  }
}
