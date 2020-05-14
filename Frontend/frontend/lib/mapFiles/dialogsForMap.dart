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

  getKm(BuildContext context){
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
          decoration: new InputDecoration(labelText: "How long?",
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
              onPressed: () => Navigator.pop(context, "-1"),
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () => Navigator.pop(context, km),
              child: Text("Generate"),
            ),
          ],
        );
      },
    );
  },
);
  }

showSavedRoutes(BuildContext context){

List<String> litems = ["Sveden","Fisken","Be","Lloo"];
  List<int> km = [200, 20 , 23, 12];

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
                height: 100,
                width: 100,
             child: new ListView.builder
  (
    padding: const EdgeInsets.all(8),
    itemCount: litems.length,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: () async {
        // dialog.confirm(context, '${litems[index]}', '${km[index]} Km');
        } ,
        child: Container(  
        height: 75,
        margin: EdgeInsets.all(2),
        color: Colors.blue,
        child: Center(
          child: Text('${litems[index]} ${km[index]} Km'),
          
          
        )


      ));
    }
    
  ),
  ),
              
            ],),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
             FlatButton(
              onPressed: () {},
              child: Text("delete"),
            ),
            FlatButton(
              onPressed: () {},
              child: Text("Open"),
            ),
          ],
        );
      },
    );
  },
);




}

}



