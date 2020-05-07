import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class RoutePickerTab2 extends StatefulWidget {
  @override
  _RoutePickerTab2 createState() => _RoutePickerTab2();

}

class _RoutePickerTab2 extends State<RoutePickerTab2> {
  List<String> litems = ["1","2","Third","4"];
  Widget build(BuildContext context){
    return new Scaffold(
      body: new ListView.builder
  (
    itemCount: litems.length,
    itemBuilder: (BuildContext ctxt, int index) {
     return new Text(litems[index]);
    }
  ),

      );
  }

}