import 'package:flutter/material.dart';
import 'package:frontend/routePickerMap/routePickerUI.dart';

class LocationPickerPage extends StatefulWidget {
  LocationPickerPage () : super();

  final String title = "Forgot Password";

  @override
  _LocationPickerPage  createState() => _LocationPickerPage ();
}

class _LocationPickerPage  extends State<LocationPickerPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String location = "";

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Forgot Password'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  new TextField(
                   onChanged: (val) {
                   setState(() => location = val); },
                   decoration: new InputDecoration(labelText: "Where do you want to go?",
                   border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black)),
          ),
        ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      child: Text('Reset Password'),
                      onPressed: () async {
                    
                      }),
                    
                ])
               
                ),
                floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                                      builder: (context) => RoutePage()),
                                );
                     },
                  icon: Icon(Icons.router),
                  label: Text('Go To Routes'),
                  foregroundColor: Colors.pink,
                  backgroundColor: Colors.purple
        ),
                );
  }
}
