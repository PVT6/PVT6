import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/browseDogParks.dart';
import 'package:frontend/routePickerMap/routePickerUI.dart';
import 'package:frontend/userFiles/user.dart';

class LocationPickerPage extends StatefulWidget {
  String location;
  LocationPickerPage ({Key key, this.location}) : super(key: key);
  final String title = "Directions";
  @override
  _LocationPickerPage  createState() => _LocationPickerPage();
}

class _LocationPickerPage  extends State<LocationPickerPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  Widget build(BuildContext context) {
  String location = widget.location;
  final myController = TextEditingController(text: location);
  
  
        return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text('Get Direcions'),
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    child: Column(children: <Widget>[
                      SizedBox(height: 20.0),
                       TextField(
                         controller: myController, 
                   decoration: new InputDecoration(labelText: "Where do you want to go?",
                   border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black)),
          ),
        ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      child: Text('Show me the way'),
                      onPressed: () async {
                        location = myController.text;
                    
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
