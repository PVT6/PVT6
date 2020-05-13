import 'package:flutter/material.dart';
import 'package:frontend/browseDogParks.dart';
import 'package:frontend/mapFiles/mapPreview.dart';
import 'package:frontend/routePickerMap/routePickerTab1.dart';
import 'package:flutter/services.dart';


class DialogForMaps {

  saveRoute(BuildContext context){
    String name = "";
    showDialog(
  context: context,
  builder: (context) {
    String contentText = "Content of Dialog";
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text("Save Route"),
          content: Row(
            children: <Widget>[
              SizedBox(
                width: 200.0,
                height: 300.0,
                child: TextField(
              onChanged: (val) {
            setState(() => name = val); },
          decoration: new InputDecoration(labelText: "Input a name",
          border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black)),
          ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
            ], // Only numbers c
            ),
              ),
            ],),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapPreviewPage(km: 22)),
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



