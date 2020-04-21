import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/cupertino.dart';
import 'mapsDemo.dart';
import 'secondRoute.dart';

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

  bool hasError = false;
  String currentText = "";
  String currentTextPW = "";

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Username",
      ),
      onChanged: (value) {
        print(value);
        setState(() {
          currentText = value;
        });
      },
    );
    //       border:
    //           OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    // );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
      ),
      onChanged: (value) {
        print(value);
        setState(() {
          currentTextPW = value;
        });
      },
    );
    //       border:
    //           OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    // );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue, //hexadecimal för ljusgrön behövs
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (currentText != "towtow" || currentTextPW != "towtow") {
            // errorController.add(
            //     ErrorAnimationType.shake); // Triggering error shake animation
            setState(() {
              hasError = true;
            });
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapsDemo()),
            );
          }
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
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.green, Colors.blue])),
            child: Stack(fit: StackFit.expand, children: <Widget>[
              SingleChildScrollView(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 70.0),
                      Row(children: <Widget>[
                        Expanded(
                          child: Image.asset(
                            'assets/logophase4png.png',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Stockholm SafeLight',
                          ),
                        ),
                      ]),
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
            ]),
          ),
        ));
  }
}
