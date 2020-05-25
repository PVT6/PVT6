import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWithRoute extends StatefulWidget {
  @override
  var points;
  var latLng;
  MapWithRoute ({Key key, this.points, this.latLng}) : super(key: key);
  _MapWithRoute createState() => _MapWithRoute();
}

class _MapWithRoute extends State<MapWithRoute> {
  @override
  Widget build(BuildContext context) {
    var points = widget.points;
    // TODO: implement build
    throw UnimplementedError();
  }
  
}