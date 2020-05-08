import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'dialogForRoutePicker.dart';


class RoutePickerTab2 extends StatefulWidget {
  @override
  _RoutePickerTab2 createState() => _RoutePickerTab2();

}

class _RoutePickerTab2 extends State<RoutePickerTab2> {
  List<String> litems = ["Sveden","Fisken","Be","Lloo"];
  List<int> km = [200, 20 , 23, 12];
  DialogForRoutePicker dialog = new DialogForRoutePicker();
  Widget build(BuildContext context){
    return new Scaffold(
      body: new ListView.builder
  (
    padding: const EdgeInsets.all(8),
    itemCount: litems.length,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: () async {
         dialog.confirm(context, '${litems[index]}', '${km[index]} Km');
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

      );
  }

}