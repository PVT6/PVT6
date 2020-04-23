import 'package:flutter/material.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
 MapController controller = new MapController();

 const kApiKey = 'pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A';
class Mapbox extends StatefulWidget {
  @override
  _MapBoxState createState() => new _MapBoxState();
 
}

class _MapBoxState extends State<Mapbox> {
  

 
  UserLocationOptions userLocationOptions;

  List<Marker> markers = [];

  

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
                context: context,
                mapController: controller,
                updateMapLocationOnPositionChange: false,
                markers: markers,
                defaultZoom: 16.0
                );
    return new Scaffold(
        appBar: new AppBar(title: new Text('Leaflet Maps')),
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
            LatLng pos = new LatLng(place.geometry.coordinates[1], place.geometry.coordinates[0]);
            controller.move( pos, 15.0 );
          
          },
          context: context,
        ),
      ),
    );
  }
}
