import 'package:flutter/material.dart';
import 'package:frontend/browseDogParks.dart';
import 'package:frontend/mapFiles/mapPreview.dart';
import 'package:frontend/routePickerMap/routePickerTab1.dart';
import 'package:flutter/services.dart';


class TestDialog {

  test(BuildContext context){
    String km = "";
    var tid = 100;

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
                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapPreviewPage(km: 22, tid: 11)),
                                  );
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



