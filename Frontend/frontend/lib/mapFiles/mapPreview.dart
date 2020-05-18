import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/routePickerMap/testDialog.dart';
import 'package:geojson/geojson.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'mapWithRoute.dart';

class _MapPreviewPageState extends State<MapPreviewPage> {
  Location location;
  static LatLng latLng = LatLng(18.064034, 18.064034);
  String kmString = "0";

  
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
    var km = int.parse(kmString);
    var Postion = latLng;
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
        Positioned(
          bottom: 1,
          right: 150,
        child: Row(
          children: <Widget>[
            Text(widget.km.toString() + "km"),
        Text("    Time:" + estimatedTime.toString()),
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
          IconButton(icon: Text('Saved Routes'), onPressed: () {showSavedRoutes(context);},),
          IconButton(icon: Text('Save Route'), onPressed: () {
            saveRoute(context, points);
          },),
          IconButton(icon: Text('Generate Route'), onPressed : () async {
            /* getKm(context).then((value){
              if(value == "-1"){

              }else{
                print(value);
                kmString = value;
                //Ha en metod som skapar nya points här
              }

            } ); */
            getKm(context);
            print(kmString);
          },),
          IconButton(icon: Text('Start Route'), onPressed: () { 

            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapWithRoute(points: points),
                  ));

           },), //Skickar med rutt datan till en ny karta.
        ],
      ),
    ),
    );
  }

  getLocation() async {
    var location = new Location();
    location.onLocationChanged.listen((currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      setState(() {
        latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
      });

      print("getLocation:$latLng");
    });
  }

  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Dialoger


    saveRoute(BuildContext context, var points){
      var savePoints = points;
    String name = "";
    showDialog(
  context: context,
  builder: (context) {
    String contentText = "Content of Dialog";
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text("Save Route"),
          content: Row(
            children: <Widget>[
              SizedBox(
                width: 200.0,
                height: 300.0,
                child: TextField(
              onChanged: (val) {
            setState(() => name = val); },
          decoration: new InputDecoration(labelText: "Input a name",
          border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black)),
          ),
            ),
              ),
            ],),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
                
              },
              child: Text("Start"),
            ),
          ],
        );
      },
    );
  },
);
   

  }

  Future<String> getKm(BuildContext context){
    TextEditingController kmController = TextEditingController();
  

    showDialog(
  context: context,
  builder: (context) {
    String contentText = "Content of Dialog";
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text("Generate a route"),
          content: Row(
            children: <Widget>[
              SizedBox(
                width: 200.0,
                height: 300.0,
                child: TextField(
                  controller: kmController,
          decoration: new InputDecoration(labelText: "How long?",
          border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black)),
          ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
            ], // Only numbers c
            ),
              ),
              SizedBox(
                width: 60.0,
                height: 300.0,
                child: Text('km'),)
            ],),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context, "-1"),
              child: Text("Cancel"),
            ),
            FlatButton(
            //  onPressed: () => Navigator.pop(context, kmController.text.toString()),
            onPressed: () {
              kmString = kmController.text.toString();
              Navigator.pop(context);
            },
              child: Text("Generate"),
            ),
          ],
        );
      },
    );
  },
);
  }

showSavedRoutes(BuildContext context){
TextEditingController editingController = TextEditingController();
List<String> litems = ["Sveden","Fisken","Be","Lloo"];
  List<int> km = [200, 20 , 23, 12];
  var items = List<String>();
  String selectedRoute = '';
  String filter;

    showDialog(
  context: context,
  builder: (context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text("Generate a route"),
          content: Row(
            children: <Widget>[
              SizedBox(
                height: 100,
                width: 100,
             child: new ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: litems.length,
    itemBuilder: (BuildContext context, int index) {
      String c = litems?.elementAt(index);
      return GestureDetector(
        onTap: () async {
          setState() {
            selectedRoute = c;
          }

          return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('${litems[index]}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
            FlatButton(
              onPressed: () {
              Navigator.pop(context);
            },
              child: Text('Delete'),
            ),
            FlatButton(
              onPressed: () {
              Navigator.pop(context);
            },
              child: Text('Open'),
            ),
          ],
        );
      }

    );

     //    String returnVal = await openRoute(context, '${litems[index]}');
     //    print(returnVal);
        } ,
        child: Container(  
        height: 75,
        margin: EdgeInsets.all(2),
        color: Colors.blue,
        child: Center(
          child: Text('${litems[index]} ${km[index]} Km'),
          
          
        )
        


      ));
    }
    
  ),
  ),
              
            ],),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  },
);




}


  Future<String> openRoute(BuildContext context, String title) async {
     return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context, 'Closed'),
              child: Text('Close'),
            ),
            FlatButton(
              onPressed: () => Navigator.pop(context, 'Delete'),
              child: Text('Delete'),
            ),
            FlatButton(
              onPressed: () => Navigator.pop(context, 'Open'),
              child: Text('Open'),
            ),
          ],
        );
      }

    );

  }












}

class MapPreviewPage extends StatefulWidget {
  @override
  var km;
  MapPreviewPage ({Key key, this.km}) : super(key: key);
  _MapPreviewPageState createState() => _MapPreviewPageState();
}
