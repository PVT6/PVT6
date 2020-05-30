


import 'package:flutter/material.dart';

import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:latlong/latlong.dart';



class SearchLocation extends StatelessWidget {
final MapController controller;

  const SearchLocation({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        bottom: false,
        child: MapBoxPlaceSearchWidget(
          language: "Swedish",
          popOnSelect: true,
          apiKey: FlutterConfig.get('MAPBOX_ID'),
          searchHint: 'Search',
          limit: 10,
          onSelected: (place) {
            LatLng pos = new LatLng(
                place.geometry.coordinates[1], place.geometry.coordinates[0]);
            controller.move(pos, 15.0);
          },
          context: context,
        ),
      ),
    );
  }
}