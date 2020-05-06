import 'package:flutter/material.dart';
import 'package:frontend/routePickerMap/routePickerTab1.dart';
import 'package:frontend/routePickerMap/routePickerTab2.dart';
import 'package:frontend/routePickerMap/routePickerTab3.dart';

class RoutePage extends StatefulWidget {
  RoutePage() : super();

  final String title = "Forgot Password";

  @override
  _RoutePage createState() => _RoutePage();
}

class _RoutePage extends State<RoutePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  bool hasError = false;
  final _formKey = GlobalKey<FormState>();
  String email = "";

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,  // Added
      initialIndex: 0,
      child: Scaffold(

        appBar: AppBar(
          elevation: 0.0,
          title: Text('Generera en rutt'),
          bottom: new TabBar(
            indicatorColor: Colors.black,
            tabs: [
            new Tab(text: "Generera en rutt"),
            new Tab(text: "Ta dig till en plats"),
            new Tab(text: "Sparade rutter")
          ]
          
          ),
          
        ),
        body: new TabBarView(
          children: [
            new routePickerTab1(),
            new routePickerTab2(),
            new routePickerTab3()
          ]
        )
    )
   );       
            
  }
}