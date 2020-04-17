import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color darkGreen = Colors.green[900];
Color lightGreen = Colors.green[100];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter login UI',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
        ));
    //       border:
    //           OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    // );
    final passwordField = TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
        ));
    //       border:
    //           OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    // );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green[900], //hexadecimal för ljusgrön behövs
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            //fixa UI för felmeddelande
            context,
            MaterialPageRoute(builder: (context) => MapsDemo()),
          );
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
        backgroundColor: lightGreen,
        body: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    emailField,
                    SizedBox(height: 20.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    loginButon,
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              //borde skapa egen sida för detta, om det inte görs med firebase?
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondRouteState()),
                              );
                            },
                            child: new Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondRouteState()),
                              );
                            },
                            child: new Text(
                                "New user? Sign up", //den här overflowar9
                                style: TextStyle(color: Colors.white)),
                          ),
                        ]),
                    Text(
                      'OR',
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SignInButton(
                          Buttons.Facebook,
                          mini: true,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapsDemo()),
                            );
                          },
                        ),
                        // SizedBox(
                        //   child: Image.asset(
                        //     "assets/googleLoginMini.png", //google mini finns ej i flutter, tillfällig lösning
                        //     fit: BoxFit.contain,
                        //   ),
                        // ),
                        SizedBox(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapsDemo()),
                            );
                          },
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                'googleLoginMini.png',
                              ),
                            ),
                          ),
                        )),
                        SignInButton(
                          Buttons.Email,
                          mini: true,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapsDemo()),
                        );
                      },
                      child: new Text("Continue without login >",
                          textAlign: TextAlign.right),
                    ),
                  ]),
            ),
          ),
        ));
  }
}

class SecondRouteState extends StatefulWidget {
  SecondRouteState() : super();

  final String title = "Maps Demo";

  @override
  SecondRoute createState() => SecondRoute();
}

class SecondRoute extends State<SecondRouteState> {
  //måste ha state, liknande mapdemo
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email adress",
        ));
    final nameField = TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
        ));
    final surnameField = TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Surname",
        ));
    final passwordField = TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
        ));
    final passwordRepeatField = TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Repeat password",
        ));
    final phoneField = TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Phone number",
        ));
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapsDemo()),
          );
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondRouteState()),
                          );
                        },
                        //child: new Text("Forgot Password?"),
                        child: new IconButton(
                          icon: Icon(Icons.arrow_back),
                          alignment: Alignment.topLeft,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                            );
                          },
                        ),
                        //BackButton({Key key, Color color, VoidCallback onPressed})
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondRouteState()),
                          );
                        },
                        child: new Text("New profile"),
                      ),
                    ]),
                SizedBox(height: 5.0),
                nameField,
                SizedBox(height: 5.0),
                surnameField,
                SizedBox(height: 5.0),
                emailField,
                SizedBox(height: 5.0),
                passwordField,
                SizedBox(height: 5.0),
                passwordRepeatField,
                SizedBox(height: 5.0),
                phoneField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MapsDemo extends StatefulWidget {
  MapsDemo() : super();

  final String title = "Maps Demo";

  @override
  MapsDemoState createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(59.334591, 18.063240);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  static final CameraPosition _position1 = CameraPosition(
    bearing: 192.833,
    target: LatLng(59.334591, 18.063240),
    tilt: 59.440,
    zoom: 11.0,
  );

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'This is a Title',
            snippet: 'This is a snippet',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
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
      backgroundColor: Colors.green[900],
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green[900],
        floatingActionButton: FloatingActionButton.extended(
          elevation: 4.0,
          icon: const Icon(Icons.add),
          label: const Text('Create new route'),
          backgroundColor: Colors.green[900],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
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
                    button(_onAddMarkerButtonPressed, Icons.add_location),
                    SizedBox(
                      height: 16.0,
                    ),
                    button(_goToPosition1, Icons.location_searching),
                  ],
                ),
              ),
            ),
          ],
        ),
        appBar: AppBar(title: Text("SafeLight Stockholm"), backgroundColor: Colors.green[900],),
        
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Jakob Ödman"),
                accountEmail: Text("fakeMail123@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.green[900],
                  child: Text(
                    "PH", //placeholder, kanske användarbild här? ändra då text till backgroundimage
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsState()),
                  );
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsState extends StatefulWidget {
  SettingsState() : super();

  final String title = "Maps Demo";

  @override
  Settings createState() => Settings();
}

class Settings extends State<SettingsState> {
  // final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  bool _dark;

  @override
  void initState() {
    super.initState();
    _dark = false;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : Colors.green[100],
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: _dark ? Colors.white : Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.moon),
              onPressed: () {
                setState(() {
                  _dark = !_dark;
                });
              },
            )
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.green[900],
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()),
                        );
                        //open edit profile
                      },
                      title: Text(
                        "Namn Efternamn",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage:
                            new AssetImage('assets/googleLoginMini.png'),
                      ),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color: Colors.green[900],
                          ),
                          title: Text("Privacy Settings"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //skapa ny sida
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.language,
                            color: Colors.green[900],
                          ),
                          title: Text("Change Language"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //ändra språk
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.green[900],
                          ),
                          title: Text("Map Settings"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change location
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Options",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SwitchListTile(
                    activeColor: Colors.green[900],
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Share Location With Friends"),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: Colors.green[900],
                    contentPadding: const EdgeInsets.all(0),
                    value: false,
                    title: Text("Enable Emergancy Button"),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: Colors.green[900],
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Enable Notifications"),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: Colors.green[900],
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Fingerprint login"),
                    onChanged: (val) {},
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
            Positioned(
              bottom: -20,
              left: -20,
              child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green[900],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: 00,
              left: 00,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.powerOff,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}

class EditProfile extends StatefulWidget {
  EditProfile() : super();

  final String title = "Maps Demo";

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: const Text('Edit Profile'), actions: <Widget>[
          new Container(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
              child: new MaterialButton(
                child: new Text('Save'),
                onPressed: () {
                  //spara ändringar
                },
              ))
        ]),
        body: new Form(
            child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            new Container(
              child: new TextField(
                decoration: const InputDecoration(labelText: "First Name"),
              ),
            ),
            new Container(
              child: new TextField(
                decoration: const InputDecoration(labelText: "Last Name"),
              ),
            ),
            new Container(
              child: new TextField(
                decoration: const InputDecoration(
                    labelText: "Email", hintText: "abc@gmail.com"),
              ),
            ),
          ],
        )));
  }
}
