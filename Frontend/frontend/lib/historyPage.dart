import 'package:flutter/material.dart';
import 'package:frontend/services/auth.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage() : super();

  final String title = "Forgot Password";

  @override
  _HistoryPage createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final AuthService _auth = AuthService();
  bool hasError = false;
  final _formKey = GlobalKey<FormState>();
  String email = "";

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('History'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            ));
  }
}