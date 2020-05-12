import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'tempDialog.dart';

class RoutePickerTab2 extends StatefulWidget {
  const RoutePickerTab2({
    Key key,
  }) : super(key: key);
  @override
  _RoutePickerTab2 createState() => _RoutePickerTab2();
}

class _RoutePickerTab2 extends State<RoutePickerTab2> {
  List<String> litems = [
    "Årsta, Stockholm",
    "Globen, Johanneshov",
    "Odenplan, Stockholm",
    "Horsntull, Stockholm"
  ];
  DialogForHistory dialog = new DialogForHistory();
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [colorLighterPink, colorPeachPink])),
                child: Column(children: <Widget>[
                  SizedBox(height: 30,),
                  Container(
                    width: 420,
                    height: 500,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: litems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () async {
                                dialog.delete(context, '${litems[index]}');
                              },
                              child: Container(
                                height: 30,
                                margin: EdgeInsets.all(2),
                                color: colorPurple,
                                child: Center(
                                  child: Text(
                                    '${litems[index]}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ));
                        }),
                  )
                ]))));
  }
}
