import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/loadingScreen.dart';
import 'package:frontend/loginFiles/forgotPasswordPage.dart';
import 'package:frontend/mapFiles/mapsDemo.dart';
import 'package:frontend/mapFiles/temp.dart';
import 'package:frontend/mapFiles/routeTest.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/wrapper.dart';
import '../fadeRoute.dart';
import 'secondRoute.dart';
import 'package:latlong/latlong.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:latlong/latlong.dart' as latlng;

LatLng basic = new LatLng(59.343431, 18.094141);

Color darkGreen = Colors.green[900];
Color lightGreen = Colors.green[100];

// Färgschema från prototyp
const colorBeige = const Color(0xFFF5F3EE);
const colorDarkBeige = const Color(0xFFc2c0bc);
const colorPrimaryRed = const Color(0xffEA9999);
const colorLightRed = const Color(0xFFffcaca);
const colorDarkRed = const Color(0xffb66a6b);

class MySignInPage extends StatefulWidget {
  MySignInPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MySignInPageState createState() => _MySignInPageState();
}

class _MySignInPageState extends State<MySignInPage>
    with SingleTickerProviderStateMixin {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  latlng.LatLng setter = latlng.LatLng(0,0);

  bool hasError = false;
  String currentText = "";
  String currentTextPW = "";
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });
    final emailField = AnimatedBuilder(
        animation: offsetAnimation,
        builder: (buildContext, child) {
          if (offsetAnimation.value < 0.0)
            print('${offsetAnimation.value + 8.0}');
          return Container(
              padding: EdgeInsets.only(
                  left: offsetAnimation.value + 24.0,
                  right: 24.0 - offsetAnimation.value),
              child: Center(
                  child: TextFormField(
                obscureText: false,
                style: style,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Username",
                  icon: new Icon(
                    Icons.mail,
                    color: colorPrimaryRed,
                  ),
                ),
                validator: (value) =>
                    value.isEmpty ? 'Email can\'t be empty' : null,
                onSaved: (value) => currentText = value.trim(),
                onChanged: (val) {
                  setState(() => currentText = val);
                },
              )));
        });
    final passwordField = AnimatedBuilder(
        animation: offsetAnimation,
        builder: (buildContext, child) {
          if (offsetAnimation.value < 0.0)
            print('${offsetAnimation.value + 8.0}');
          return Container(
              padding: EdgeInsets.only(
                  left: offsetAnimation.value + 24.0,
                  right: 24.0 - offsetAnimation.value),
              child: Center(
                child: TextFormField(
                  obscureText: true,
                  style: style,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Password",
                    icon: new Icon(
                      Icons.lock,
                      color: colorPrimaryRed,
                    ),
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Password can\'t be empty' : null,
                  onSaved: (value) => currentTextPW = value.trim(),
                  onChanged: (val) {
                    setState(() => currentTextPW = val);
                  },
                ),
              ));
        });

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: colorPrimaryRed, //hexadecimal för ljusgrön behövs
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            dynamic result = await _auth.signInWithEmailAndPassword(
                currentText, currentTextPW);
            print(result);
             
            if (result == null) {
              controller.forward(from: 0.0); 
            } else {
              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoadingScreen(result)),
                                );
            }
          }
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
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [colorBeige, colorDarkBeige])),
        child: Stack(fit: StackFit.expand, children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      SizedBox(
                        width: 280,
                        height: 200,
                        child: Image.asset(
                          'assets/logoprototype.png',
                        ),
                      ),
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
                                child: Text(
                                  "Forgot Password?",
                                  style: style.copyWith(
                                    color: colorDarkRed,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              onPressed: () {
                                //borde skapa egen sida för detta, om det inte görs med firebase?
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordPage()),
                                );
                              },
                            ),
                            FlatButton(
                                child: Text(
                                  "New user? Sign up",
                                  style: style.copyWith(
                                    color: colorDarkRed,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SecondRouteState()),
                                );
                              },
                            ),
                          ]),
                      Text(
                        'OR',
                        textAlign: TextAlign.center,
                      ),
                      Row(children: <Widget>[SizedBox(height: 20.0)]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                              child: InkWell(
                            onTap: () async {
                              dynamic result = await _auth.facebookSignIn();
                              print(result);
                              if (result == null) {
                                setState(() {
                                  hasError = true;
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoadingScreen(result)),
                                );
                              }
                            },
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  'facebookicon140pxl.png',
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                          )),
                          SizedBox(
                              child: InkWell(
                            onTap: () async {
                              dynamic result = await _auth.googleSignIn();
                              print(result);
                              if (result == null) {
                                setState(() {
                                  hasError = true;
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoadingScreen(result)),
                                );
                              }
                            },
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  'googleicon144pxl.png',
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                          )),
                          SizedBox(
                              child: InkWell(
                            onTap: () async {
                              dynamic result = await _auth.googleSignIn();
                              print(result);
                              if (result == null) {
                                setState(() {
                                  hasError = true;
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoadingScreen(result)),
                                );
                              }
                            },
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  'emailicon100pxl.png',
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPage()),
                          );
                        },
                        child: new Text("Continue without login >",
                            textAlign: TextAlign.right),
                      ),
                    ])),
          ),
        ]),
      ),
    ));
  }
}


