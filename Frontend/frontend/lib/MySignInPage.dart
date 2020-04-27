import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/forgotPasswordPage.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/temp.dart';
import 'mapsDemo.dart';
import 'secondRoute.dart';
import 'package:latlong/latlong.dart';

LatLng basic = new LatLng(59.343431, 18.094141);

Color darkGreen = Colors.green[900];
Color lightGreen = Colors.green[100];

class MySignInPage extends StatefulWidget {
  MySignInPage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _MySignInPageState createState() => _MySignInPageState();
}

class _MySignInPageState extends State<MySignInPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  bool hasError = false;
  String currentText = "";
  String currentTextPW = "";
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
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
    );
    //       border:
    //           OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    // );
    final passwordField = TextFormField(
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
      validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      onSaved: (value) => currentTextPW = value.trim(),
      onChanged: (val) {
        setState(() => currentTextPW = val);
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
        onPressed: () async {
          dynamic result = await _auth.signInWithEmailAndPassword(
              currentText, currentTextPW);
          print(result);
          if (result == null) {
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
                                              SecondRouteState()),
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
                                          builder: (context) =>
                                              ForgotPasswordPageState()),
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
                                MaterialPageRoute(
                                    builder: (context) => MapsDemo()),
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
