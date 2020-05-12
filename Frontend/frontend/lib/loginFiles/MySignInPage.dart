import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/loginFiles/forgotPasswordPage.dart';
import 'package:frontend/mapFiles/mapsDemo.dart';
import 'package:frontend/mapFiles/temp.dart';
import 'package:frontend/mapFiles/routeTest.dart';
import 'package:frontend/services/auth.dart';
import 'secondRoute.dart';
import 'package:latlong/latlong.dart';

LatLng basic = new LatLng(59.343431, 18.094141);

Color darkGreen = Colors.green[900];
Color lightGreen = Colors.green[100];

class MySignInPage extends StatefulWidget {
  MySignInPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MySignInPageState createState() => _MySignInPageState();
}

class _MySignInPageState extends State<MySignInPage>
    with SingleTickerProviderStateMixin {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

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
          color: Colors.grey,
        ),
      ),
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      onSaved: (value) => currentText = value.trim(),
      onChanged: (val) {
        setState(() => currentText = val);
      },
    )));});
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
                      color: Colors.grey,
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
      color: Colors.blue, //hexadecimal för ljusgrön behövs
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
                MaterialPageRoute(builder: (context) => MapsDemo()),
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
                colors: [Colors.blue, Colors.blue.shade200])),
        child: Stack(fit: StackFit.expand, children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(36.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 70.0),
                      Row(children: <Widget>[
                        Expanded(
                          child: Image.asset(
                            'assets/DogLogo.png',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Dog App',
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
                                      builder: (context) =>
                                          ForgotPasswordPage()),
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
                            onPressed: () async {
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
                                      builder: (context) => MapsDemo()),
                                );
                              }
                            },
                          ),
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
                                      builder: (context) => MapsDemo()),
                                );
                              }
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Mapbox(basic)),
                              );
                            },
                          ),
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


