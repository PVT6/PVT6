import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class RoutePickerTab3 extends StatefulWidget {
  @override
  _RoutePickerTab3 createState() => _RoutePickerTab3();

}

class _RoutePickerTab3 extends State<RoutePickerTab3> {
  int km = 0;
  Widget build(BuildContext context){
    return new Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(children: <Widget>[
         new TextField(
          decoration: new InputDecoration(labelText: "How long in km?",
          border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black)),
          ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
        ),
        
        ]


      )));
  }

}