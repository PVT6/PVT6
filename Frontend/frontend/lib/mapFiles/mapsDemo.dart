import 'dart:core';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/browseDogParks.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/friendsAndContacts/friendsPage.dart';
import 'package:frontend/friendsAndContacts/sharePos.dart';
import 'package:frontend/infoPage.dart';
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
List<Marker> markers = [];
// Färgschema #1
const colorPurple = const Color(0xFF82658f);
const colorPeachPink = const Color(0xFFffdcd2);
const colorLighterPink = const Color(0xFFffe9e5);
TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

class MapsDemo extends StatefulWidget {
  LatLng coordinates;
  MapsDemo(this.coordinates) : super();

  final String title = "Maps Demo";

  @override
  MapsDemoState createState() => MapsDemoState();
}

void updateFriensPos() {
  markers.clear();
  posName.forEach((element) {
    Marker m = Marker(
        width: 130.0,
        height: 95.0,
        point: new LatLng(element.pos.latitude, element.pos.longitude),
        builder: (context) => new Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(element.name,
                        style: TextStyle(
                          letterSpacing: 1,
                          backgroundColor: Colors.white,
                          color: textYellow,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Hipster Script W00 Regular',
                        )),
                    IconButton(
                      icon: Icon(Icons.person_pin, color: colorDarkRed),
                      iconSize: 40.0,
                      tooltip: element.name,
                      onPressed: () {},
                      color: Colors.blue,
                    ),
                  ]),
            ));

    markers.add(m);
  });
  print(markers);
}

class MapsDemoState extends State<MapsDemo> {
  MapController controller = new MapController();
  final AuthService _auth = AuthService();
  UserLocationOptions userLocationOptions;
  Position position;
  int counter = 0;
  List<CameraDescription> cameras;
  bool cameraState = false;

  //Location(name: "Lumaparken", latitude: 59.303985, longitude: 18.097073);
  double userLat = 59.303985;
  double userLng = 18.097073;

  void initState() {
    super.initState();
    getCameras();
    getLocation();
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
      backgroundColor: colorBeige,
      child: Icon(
        icon,
        size: 36.0,
        color: colorDarkRed,
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
      drawer: Drawer(
        child: Container(
            color: colorBeige,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: <Color>[
                      colorPrimaryRed,
                      colorBeige,
                      colorPrimaryRed
                    ])),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            child: Image.asset(
                              "logoprototype.png",
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Text(
                            userlib.name, //userData
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Hipster Script W00 Regular',
                                fontSize: 18.0,
                                letterSpacing: 2.5),
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
                        }),
                CustomListTile(
                    FontAwesomeIcons.infoCircle,
                    'About DogWalk',
                    () => {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => DetailPage()))
                        }),
                //Tror denna kan behövs senare då logout antagligen är fel implementerad
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
                  height: 350,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      elevation: 5.0,
                      color: colorDarkRed,
                      child: MaterialButton(
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
                            style: style.copyWith(
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
                        zoom: 17,
                        //center: LatLng(position.latitude, position.longitude),
                        center: widget.coordinates.latitude == 0 &&
                                widget.coordinates.longitude == 0
                            ? LatLng(59.303985, 18.097073)
                            : widget.coordinates,
                        minZoom: 4.0,
                        maxZoom: 20,
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
                        new MarkerLayerOptions(markers: markers),
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
                    // !!!!!!!!!!!!!!!!!!!!!!!!Kommentarer under är om vi vill ha en notification knapp
                    // Container(
                    //   height: 60,
                    //   width: 60,
                    //   child: Stack(
                    //     children: <Widget>[
                    //       new FloatingActionButton(
                    //         heroTag: _randomString(10),
                    //         onPressed: () {
                    //           setState(() {
                    //             counter++; //denna är för test, counter ska sedan hålla notifications

                    //             markers.first = Marker(
                    //               width: 45.0,
                    //               height: 45.0,
                    //               point: new LatLng(59.315499, 18.076973),
                    //               builder: (context) => new Container(
                    //                 child: IconButton(
                    //                   icon: Icon(Icons.donut_large),
                    //                   onPressed: null,
                    //                   color: Colors.red,
                    //                   iconSize: 45.0,
                    //                 ),
                    //               ),
                    //             );
                    //           });
                    //         },
                    //         materialTapTargetSize: MaterialTapTargetSize.padded,
                    //         backgroundColor: colorBeige,
                    //         child: Icon(
                    //           FontAwesomeIcons.solidBell,
                    //           size: 36.0,
                    //           color: colorDarkRed,
                    //         ),
                    //       ),
                    //       counter != 0
                    //           ? new Positioned(
                    //               right: 11,
                    //               top: 11,
                    //               child: new Container(
                    //                 padding: EdgeInsets.all(2),
                    //                 decoration: new BoxDecoration(
                    //                   color: Colors.red,
                    //                   borderRadius: BorderRadius.circular(6),
                    //                 ),
                    //                 constraints: BoxConstraints(
                    //                   minWidth: 14,
                    //                   minHeight: 14,
                    //                 ),
                    //                 child: Text(
                    //                   '$counter',
                    //                   style: TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 8,
                    //                   ),
                    //                   textAlign: TextAlign.center,
                    //                 ),
                    //               ),
                    //             )
                    //           : new Container()
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 220,
                    // ),

                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Slut på notificationknapp
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
                        color: colorDarkRed,
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
                                "Search",
                                style: style.copyWith(
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
