import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class RoutePickerTab1 extends StatefulWidget {
  @override
  _RoutePickerTab1 createState() => _RoutePickerTab1();

}

class _RoutePickerTab1 extends State<RoutePickerTab1> {
  String km = "0";
  Widget build(BuildContext context){
    return new Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(children: <Widget>[
         new TextField(
           onChanged: (val) {
            setState(() => km = val); },
          decoration: new InputDecoration(labelText: "How long in km?",
          border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black)),
          ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
        ),
        RaisedButton(
                      child: Text('Reset Password'),
                      onPressed: () async {
                        if (km != "0" && km != "") {
                          
                        }
                      })
        
        ]


      )));
  }

}