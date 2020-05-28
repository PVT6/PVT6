import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/browseDogParks.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/friendsAndContacts/friendsPage.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:frontend/mapFiles/mapBoxSearch.dart';
import 'package:frontend/mapFiles/mapPreview.dart';
import 'package:frontend/mapFiles/temp.dart';
import 'package:frontend/mapFiles/temp2.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/settings.dart';
import 'package:frontend/userFiles/user.dart' as userlib;
import 'package:frontend/userFiles/profile.dart';
import 'package:user_location/user_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import '../dog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:frontend/cameraScreen.dart';

MapController controller = new MapController();

// Färgschema #1
const colorPurple = const Color(0xFF82658f);
const colorPeachPink = const Color(0xFFffdcd2);
const colorLighterPink = const Color(0xFFffe9e5);

class MapsDemo extends StatefulWidget {
  MapsDemo() : super();

  final String title = "Maps Demo";

  @override
  MapsDemoState createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
  MapController controller = new MapController();
  final AuthService _auth = AuthService();
  UserLocationOptions userLocationOptions;
  Position position;
  int counter = 0;
  List<CameraDescription> cameras;
  bool cameraState = false;
  List<Marker> markers = [];
  MarkerLayerOptions layer2 ;
  //Location(name: "Lumaparken", latitude: 59.303985, longitude: 18.097073);
  double userLat = 59.303985;
  double userLng = 18.097073;

  void initState() {
    super.initState();
    getCameras();
    getLocation();
    Marker m = Marker(
      width: 45.0,
      height: 45.0,
      point: new LatLng(59.303985, 18.097073),
      builder: (context) => new Container(
        child: IconButton(
          icon: Icon(Icons.child_friendly),
          onPressed: null,
          color: Colors.blue,
          iconSize: 45.0,
        ),
      ),
    );

    markers.add(m);
  }

  Future<Null> getCameras() async {
    setState(() async {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    });
  }

  Future<void> getLocation() async {
    Position temp = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    position = temp;
  }

  showCameraFailAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: colorPeachPink,
      title: Text(
        "Error (Camera Open)",
        style: TextStyle(color: Colors.red),
      ),
      content: Text(
          "To search for a location please make sure you are on the map view!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String _randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      heroTag: _randomString(10),
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: colorPeachPink,
      child: Icon(
        icon,
        size: 36.0,
        color: colorPurple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: controller,
      markers: markers,
      updateMapLocationOnPositionChange: false,
    );
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //         onPressed: () {
      //           setState(() {

      //           });
      //         },
      //         tooltip: "Centre FAB",
      //         child: Container(
      //           margin: EdgeInsets.all(15.0),
      //           child: Icon(Icons.camera_alt),
      //         ),
      //         elevation: 4.0,
      //       ),
      drawer: Drawer(
        child: Container(
            color: colorLighterPink,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[colorPurple, colorPeachPink])),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            child: Image.asset(
                              "logopurplepink.png",
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Text(
                            userlib.name, //userData
                            style: TextStyle(
                                color: textYellow,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Hipster Script W00 Regular',
                                fontSize: 18.0,
                                letterSpacing: 1.1),
                          ),
                        ],
                      ),
                    )),
                CustomListTile(
                    Icons.person,
                    'Profile',
                    () => {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => ProfileEightPage()))
                        }),
                CustomListTile(
                    Icons.contact_phone,
                    'Connections',
                    () => {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => FriendsPage()))
                        }),
                CustomListTile(
                    Icons.settings,
                    'Settings',
                    () => {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => Settings()))
                        }),
                CustomListTile(
                    FontAwesomeIcons.dog,
                    'Browse Dogfriendly Places',
                    () => {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => BrowseDogParks()))
                        }), //Tror denna kan behövs senare då logout antagligen är fel implementerad
                // CustomListTile(
                //     Icons.lock,
                //     'Log out',
                //     () async => {
                //           await _auth.signOut(),
                //           Navigator.push(
                //               context,
                //               new MaterialPageRoute(
                //                   builder: (context) => MySignInPage()))
                //         }),
                SizedBox(
                  height: 240,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Material(
                      elevation: 5.0,
                      color: Colors.red,
                      child: MaterialButton(
                        minWidth: 120,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      MySignInPage())); // dismiss dialog
                        },
                        child: Text("Sign out",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
      body: Builder(builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            !cameraState == true
                ? FlutterMap(
                    mapController: controller,
                    options: new MapOptions(
                        center: LatLng(0, 0),
                        minZoom: 15.0,
                        plugins: [
                          // ADD THIS
                          UserLocationPlugin(),
                        ]), //ändra detta till coordinate för att komma tillbaka till stockholm
                    layers: [
                        new TileLayerOptions(
                            urlTemplate: FlutterConfig.get('MAPBOXAPI_URL'),
                            additionalOptions: {
                              'accessToken': FlutterConfig.get('MAPBOX_ID'),
                              'id': 'mapbox.mapbox-streets-v8'
                            }),
                        layer2 = new MarkerLayerOptions(markers: markers),
                        // ADD THIS
                        userLocationOptions,
                      ])
                : CameraScreen(cameras),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      child: Stack(
                        children: <Widget>[
                          new FloatingActionButton(
                            heroTag: _randomString(10),
                            onPressed: () {
                              setState(() {
                                counter++; //denna är för test, counter ska sedan hålla notifications

                                markers.first = Marker(
                                  width: 45.0,
                                  height: 45.0,
                                  point: new LatLng(18.076973, 59.315499),
                                  builder: (context) => new Container(
                                    child: IconButton(
                                      icon: Icon(Icons.donut_large),
                                      onPressed: null,
                                      color: blue,
                                      iconSize: 45.0,
                                    ),
                                  ),
                                );
                                layer2.rebuild.listen((event) { });
                              });
                            },
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: colorPeachPink,
                            child: Icon(
                              FontAwesomeIcons.solidBell,
                              size: 36.0,
                              color: colorPurple,
                            ),
                          ),
                          counter != 0
                              ? new Positioned(
                                  right: 11,
                                  top: 11,
                                  child: new Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: new BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 14,
                                      minHeight: 14,
                                    ),
                                    child: Text(
                                      '$counter',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              : new Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 220,
                    ),
                    button(_onMapTypeButtonPressed, FontAwesomeIcons.dice),
                    SizedBox(
                      height: 16.0,
                    ),
                    button(
                        _onAddMarkerButtonPressed, FontAwesomeIcons.directions),
                    SizedBox(
                      height: 16.0,
                    ),
                    button(_goToPosition1, Icons.photo_camera),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 50,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        color: Colors.white,
                        elevation: 20,
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Search Around",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.mic,
                                size: 30,
                              ),
                            ],
                          ),
                          color: Colors.white,
                          onPressed: () {
                            !cameraState == true
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchLocation(
                                        controller: controller,
                                      ),
                                    ),
                                  )
                                : showCameraFailAlertDialog(context);
                          },
                        )),
                    SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Container(
                          height: 30,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: <Widget>[
                              Container(
                                width: 110,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.transparent)),
                                  color: colorPeachPink,
                                  onPressed: () {},
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.restaurant,
                                        color: colorPurple,
                                      ),
                                      Text("Restaurant",
                                          style: TextStyle(fontSize: 11)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 90,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.transparent)),
                                  color: colorPeachPink,
                                  onPressed: () {},
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.nature,
                                        color: colorPurple,
                                      ),
                                      Text("Parks",
                                          style: TextStyle(fontSize: 11)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: 110,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color: Colors.transparent)),
                                    color: colorPeachPink,
                                    onPressed: () {},
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.trash,
                                          color: colorPurple,
                                        ),
                                        Text("Trashcans",
                                            style: TextStyle(fontSize: 11)),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 122,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.transparent)),
                                  color: colorPeachPink,
                                  onPressed: () {},
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.lightbulb,
                                        color: colorPurple,
                                      ),
                                      Text("Street Lamps",
                                          style: TextStyle(fontSize: 11)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  _onMapTypeButtonPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapPreviewPage()));
  }

  _onAddMarkerButtonPressed() {
    // (position == null)
    //     ? setState(() {
    //         getLocation();
    //       }):
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => Navigation(userLat, userLng)));
  }

  _goToPosition1() {
    setState(() {
      if (cameraState == false) {
        cameraState = true;
      } else {
        cameraState = false;
      }
    });
  }

  //_openNotifications() {}
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: onTap,
            child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Text(
                          text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ))),
      ),
    );
  }
}
