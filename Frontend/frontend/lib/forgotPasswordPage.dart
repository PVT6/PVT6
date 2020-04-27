import 'package:flutter/material.dart';
import 'package:frontend/services/auth.dart';
import 'MySignInPage.dart';

class ForgotPasswordPageState extends StatefulWidget {
  ForgotPasswordPageState() : super();

  final String title = "Forgot Password";

  @override
  _ForgotPasswordPage createState() => _ForgotPasswordPage();
}


class _ForgotPasswordPage extends State<MySignInPage> {

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final AuthService _auth = AuthService();
  bool hasError = false;

Widget build(BuildContext context) {
  String email = "";

  return Scaffold(
    appBar: AppBar(
      elevation: 0.0,
      title: Text('Forgot Password'),
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MySignInPage()),
                              );

          },
        )
      ]
    ),

    body: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0 ),
      child: Form(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              onChanged: (val) {
                setState(() => email = val);
              }
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              child: Text('Reset Password'),
              onPressed: () async{

              }
            )
          ]

        )
      )



    )



  );

  

}


}

