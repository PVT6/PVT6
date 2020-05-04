import 'package:flutter/material.dart';
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
          elevation: 0.0,
          title: Text('Forgot Password'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter an email.' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      child: Text('Reset Password'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await _auth.sendPasswordResetEmail(email);
                        }
                      })
                ]))));
  }
}
