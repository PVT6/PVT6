
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/services/auth.dart';


import 'mapsDemo.dart';

class SecondRouteState extends StatefulWidget {
  SecondRouteState() : super();

  final String title = "Maps Demo";

  @override
  SecondRoute createState() => SecondRoute();
}

class SecondRoute extends State<SecondRouteState> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String phone = '';
  String firstname = '';
  String lastname = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.green, Colors.blue])),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 80.0),
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      "New User",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextField(
                     onChanged: (val) {
                    setState(() => firstname = val);
                  },
                  decoration: InputDecoration(
                      labelText: "Name", hasFloatingPlaceholder: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextField(
                     onChanged: (val) {
                    setState(() => lastname = val);
                  },
                  decoration: InputDecoration(
                      labelText: "Last name", hasFloatingPlaceholder: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  decoration: InputDecoration(
                      labelText: "Email", hasFloatingPlaceholder: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextField(
                     onChanged: (val) {
                    setState(() => phone = val);
                  },
                  decoration: InputDecoration(
                      labelText: "Phone number", hasFloatingPlaceholder: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password", hasFloatingPlaceholder: true),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Confirm password",
                      hasFloatingPlaceholder: true),
                ),
              ), //Tips till Terms and conditions nedan
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              //   child: Text.rich(
              //     TextSpan(children: [
              //       TextSpan(
              //           text: "By clicking Sign Up you agree to the following "),
              //       TextSpan(
              //           text: "Terms and Conditions",
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, color: Colors.indigo)),
              //       TextSpan(text: " withour reservations."),
              //     ]),
              //   ),
              // ),
              const SizedBox(height: 60.0),
              Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                  color: Colors.yellow,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0))),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password, phone, lastname, firstname);
                      if (result == null) {
                        setState(() {
                          error = 'Please supply a valid email';
                        });
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapsDemo()),
                        );
                      }
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Sign up".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      const SizedBox(width: 40.0),
                      Icon(
                        FontAwesomeIcons.arrowRight,
                        size: 18.0,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    ));
  }
}


