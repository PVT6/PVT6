import 'package:flutter/widgets.dart';

class MapWithRoute extends StatefulWidget {
  @override
  var points;
  MapWithRoute ({Key key, this.points}) : super(key: key);
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