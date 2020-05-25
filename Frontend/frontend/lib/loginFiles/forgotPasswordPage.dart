import 'package:flutter/material.dart';
import 'package:frontend/friendsAndContacts/addContactPage.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:frontend/services/auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage() : super();

  final String title = "Forgot Password";

  @override
  _ForgotPasswordPage createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final AuthService _auth = AuthService();
  bool hasError = false;
  final _formKey = GlobalKey<FormState>();
  String email = "";

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorDarkBeige,
          elevation: 0.0,
          title: Text('Forgot Password', style: style.copyWith(
            color: colorDarkRed
          ),),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                     decoration: new InputDecoration(labelText: "Enter Email", labelStyle: style.copyWith(fontSize: 18.0)),
                      validator: (val) =>
                          val.isEmpty ? 'Enter an email.' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)
                          )),
                    color: colorLightRed,
                      child: Text('Reset Password', style: style.copyWith(
                        fontSize: 15.0
                      ),),
                      textColor: colorDarkRed,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await _auth.sendPasswordResetEmail(email);
                        }
                      })
                ]))));
  }
}
