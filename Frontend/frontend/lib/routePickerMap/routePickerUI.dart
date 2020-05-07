import 'package:flutter/material.dart';
import 'package:frontend/routePickerMap/routePickerTab1.dart';
import 'package:frontend/routePickerMap/routePickerTab2.dart';
import './locationPickerPage.dart';

class RoutePage extends StatefulWidget {
  RoutePage() : super();

  final String title = "Forgot Password";

  @override
  _RoutePage createState() => _RoutePage();
}

class _RoutePage extends State<RoutePage> {

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,  // Added
      initialIndex: 0,
      child: Scaffold(

        appBar: AppBar(
          elevation: 0.0,
          title: Text('Generera en rutt'),
          bottom: new TabBar(
            indicatorColor: Colors.black,
            tabs: [
            new Tab(text: "Generera en rutt"),
            new Tab(text: "Sparade rutter")
          ]
          
          ),
          
        ),
        body: new TabBarView(
          children: [
            new RoutePickerTab1(),
            new RoutePickerTab2()
          ]
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(
                                      builder: (context) => LocationPickerPage()),
                                );
          },
          icon: Icon(Icons.directions),
          label: Text('Go To Directions'),
          foregroundColor: Colors.pink,
          backgroundColor: Colors.purple
        ),
    )
   );       
            
  }
}