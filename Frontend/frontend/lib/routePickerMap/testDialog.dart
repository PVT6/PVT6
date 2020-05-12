import 'package:flutter/material.dart';
import 'package:frontend/browseDogParks.dart';
import 'package:frontend/routePickerMap/routePickerTab1.dart';
import 'package:flutter/services.dart';


class TestDialog {

  test(BuildContext context){
    String km = "";
    showDialog(
  context: context,
  builder: (context) {
    String contentText = "Content of Dialog";
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text("Generate a route"),
          content: Row(
            children: <Widget>[
              SizedBox(
                width: 200.0,
                height: 300.0,
                child: TextField(
              onChanged: (val) {
            setState(() => km = val); },
          decoration: new InputDecoration(labelText: "How long in km?",
          border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black)),
          ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
            ], // Only numbers c
            ),
              ),
              SizedBox(
                width: 60.0,
                height: 300.0,
                child: Text('km'),)
            ],),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
              
              },
              child: Text("Saved Routes"),
            ),
            FlatButton(
              onPressed: () {
                
              },
              child: Text("Start"),
            ),
          ],
        );
      },
    );
  },
);
   

  }
}


class TestDialog2 extends StatefulWidget {
  @override
  _TestDialog2 createState() => new _TestDialog2();
}

class _TestDialog2 extends State<TestDialog2> {
  String km = "";

  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        color: blue,
        height: 20.0,
        width: 20.0,
      ),
      actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
              
              },
              child: Text("Saved Routes"),
            ),
            FlatButton(
              onPressed: () {
                
              },
              child: Text("Start"),
            ),
      ]
    );
      
       }

}