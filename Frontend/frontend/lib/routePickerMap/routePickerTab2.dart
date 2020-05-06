import 'package:flutter/material.dart';


class RoutePickerTab2 extends StatefulWidget {
  @override
  _RoutePickerTab2 createState() => _RoutePickerTab2();

}

class _RoutePickerTab2 extends State<RoutePickerTab2> {
  final _formKey = GlobalKey<FormState>();
  String platsNamn = "";
  Widget build(BuildContext context){
    return new Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
           child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Ge en plats'
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Ge en plats.' : null,
                      onChanged: (val) {
                        setState(() => platsNamn = val);
                      }),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      child: Text('Ta dig till platsen'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          
                        }
                      })
                ]
        )

      )


      ));
  }

}