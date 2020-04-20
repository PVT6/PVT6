import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import 'contacts.dart';
import 'settings.dart';

const apiKey = "AIzaSyCDdx8s1gSU908drNXjk-T7JA4ZMTEBOD4";

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
const LatLng DEST_LOCATION = LatLng(37.335685, -122.0605916);

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  bool loading = true;
  final Set<Marker> _markers = Set<Marker>();
  //final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  //Set<Polyline> get polyLines => _polyLines;
  Completer<GoogleMapController> _controller = Completer();
  static LatLng latLng;
  LocationData currentLocation;
  LocationData destinationLocation;
  MapType _currentMapType = MapType.normal;
  static const LatLng _center = const LatLng(59.334591, 18.063240);
  LatLng _lastMapPosition = _center;
  Location location;

  Set<Polyline> _polyLines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();
    loading = true;
    location = new Location();
    polylinePoints = PolylinePoints();

    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      updatePinOnMap();
    });
    getLocation();
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    
      setState(() async {

            final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
        // updated position
        var pinPosition =
            LatLng(currentLocation.latitude, currentLocation.longitude);

        // the trick is to remove the marker (by id)
        // and add it again at the updated location
        _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
        _markers.add(Marker(
            markerId: MarkerId('sourcePin'),
            position: pinPosition, // updated position
            icon: BitmapDescriptor.defaultMarker));
      });
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    // get a LatLng out of the LocationData object
    //  var destPosition = LatLng(destinationLocation.latitude,
    //  destinationLocation.longitude);
    // add the initial source location pin
    _markers.add(Marker(
      markerId: MarkerId('sourcePin'),
      position: pinPosition,
      icon: BitmapDescriptor.defaultMarker,
    ));
    // destination pin
    //  _markers.add(Marker(
    //     markerId: MarkerId('destPin'),
    //     position: destPosition,
    //     icon: destinationIcon
    //  ));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    //setPolylines();
  }

  void setPolylines() async {
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        currentLocation.latitude,
        currentLocation.longitude,
        destinationLocation.latitude,
        destinationLocation.longitude);
    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        _polyLines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();
  }

  String _randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
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
      //_onAddMarkerButtonPressed();
      loading = false;
    });
  }

  // void _onAddMarkerButtonPressed() {
  //   setState(() {
  //     _markers.add(Marker(
  //       markerId: MarkerId("111"),
  //       position: latLng,
  //       icon: BitmapDescriptor.defaultMarker,
  //       infoWindow: InfoWindow(
  //         title: 'You are here',
  //         snippet: 'Info',
  //       ),
  //     ));
  //   });
  // }

  void onCameraMove(CameraPosition position) {
    latLng = position.target;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void sendRequest() async {
    LatLng destination = _lastMapPosition; //LatLng(59.334591, 18.063240);
    String route =
        await _googleMapsServices.getRouteCoordinates(latLng, destination);
    setPolylines();
    _addMarker(destination, "Destination");
  }

  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.red));
  }

  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId("112"),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
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

  _handleTap(LatLng point) {
    setState(() {
      _lastMapPosition = point;
      destinationLocation = LocationData.fromMap(
          {"latitude": point.latitude, "longitude": point.longitude});
      _markers.add(
        Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          infoWindow: InfoWindow(
            title: 'This is a Title',
            snippet: 'This is a snippet',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print("getLocation111:$latLng");
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            sendRequest();
          },
          label: const Text('Create new route'),
          backgroundColor: Colors.blue,
          icon: Icon(Icons.directions_boat),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Stack(
          children: <Widget>[
            loading
                ? Container(
                    color: Colors.red,
                  )
                : GoogleMap(
                    myLocationEnabled: true,
                    compassEnabled: true,
                    tiltGesturesEnabled: false,
                    polylines: _polyLines,
                    markers: _markers,
                    mapType: _currentMapType,
                    initialCameraPosition: CameraPosition(
                      target: latLng,
                      zoom: 14.4746,
                    ),
                    onTap: _handleTap,
                    onCameraMove: onCameraMove,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);

                      showPinsOnMap();
                    },
                  ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    button(_onMapTypeButtonPressed, Icons.map),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          title: Text("SafeLight Stockholm"),
          backgroundColor: Colors.blue,
        ),
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
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
              ),
              ListTile(
                title: Text('Contacts'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Contacts()),
                  );
                },
              ),
              ListTile(
                title: Text('Placeholder'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }
}
