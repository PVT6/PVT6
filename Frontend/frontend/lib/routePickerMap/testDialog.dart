import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/browseDogParks.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:frontend/mapFiles/mapPreview.dart';
import 'package:frontend/routePickerMap/routePickerTab1.dart';
import 'package:flutter/services.dart';
import 'package:bordered_text/bordered_text.dart';

class TestDialog {
  test(BuildContext context) {
    String km = "";

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                backgroundColor: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 100.0,
                          ),
                          Container(
                            height: 100.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                color: Colors.white),
                          ),
                          Positioned(
                            top: 20.0,
                            left: 140.0,
                            child: new Container(
                                height: 70.0,
                                width: 70.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(45.0),
                                    border: Border.all(
                                      color: colorPurple,
                                      style: BorderStyle.solid,
                                      width: 3.0,
                                    ),
                                    image: new DecorationImage(
                                      image: new AssetImage('assets/pin.png'),
                                      fit: BoxFit.cover,
                                    ))),
                          ),
                        ],
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 60,
                              width: 145,
                              child: TextField(
                                onChanged: (val) {
                                  setState(() => km = val);
                                },
                                decoration: new InputDecoration(
                                  labelText: "How long in km?",
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      borderSide: new BorderSide(
                                        color: colorPurple,
                                      )),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            BorderedText(
                                strokeWidth: 6.0,
                                strokeColor: colorPurple,
                                child: Text(
                                  'km',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton(
                              color: colorPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {},
                              color: colorPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Saved Routes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MapPreviewPage(km: 22)),
                                );
                              },
                              color: colorPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Start",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                      SizedBox(height: 15),
                    ]),
              );
            },
          );
        });
  }
}