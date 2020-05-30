import 'package:flutter/material.dart';

import 'package:frontend/loginFiles/MySignInPage.dart';

import 'package:latlong/latlong.dart';

import 'package:frontend/mapFiles/mapsDemo.dart';
import 'package:geocoder/geocoder.dart';
import 'package:frontend/mapFiles/temp2.dart';

class DogPlaceDesc2 extends StatelessWidget {
  final String image;
  final String rating;
  final String location;
  final String title;
  final String desc;
  final Function directions;
  final Function commonRoutes;
  final LatLng coordinates;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  getLocationName() async {
    final coordinates1 =
        new Coordinates(coordinates.latitude, coordinates.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates1);
    var first = addresses.first;
    return addresses.first.addressLine;
  }

  DogPlaceDesc2(this.image, this.rating, this.location, this.title, this.desc,
      this.directions, this.commonRoutes, this.coordinates);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDarkBeige,
        title: Text(
          'Description',
          style: style.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(image, fit: BoxFit.cover,)),
                Positioned(
                  bottom: 20.0,
                  left: 20.0,
                  right: 20.0,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        rating,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FutureBuilder<dynamic>(
                          future: getLocationName(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data,
                                style: style.copyWith(fontSize: 13),
                              );
                            } else {
                              return Text(
                                "Loading",
                                style: style.copyWith(fontSize: 13),
                              );
                            }
                          },
                        ),
                        //Text(getLocationName(), style: style.copyWith(fontSize: 13),),
                      ),
                    ],
                  ),
                  Text(
                    title,
                    style: style.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.favorite_border),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text("20.2k", style: style.copyWith(fontSize: 15.0)),
                      SizedBox(
                        width: 16.0,
                      ),
                      Icon(Icons.comment),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text("2.2k", style: style.copyWith(fontSize: 15.0)),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    desc,
                    style: style.copyWith(fontSize: 13),
                    textAlign: TextAlign.justify,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Text('View on Map',
                                style: style.copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                            color: colorDarkRed,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MapsDemo(coordinates)),
                              );
                            },
                          ),
                          FlatButton(
                            child: Text(
                              'Directions',
                              style: style.copyWith(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            color: colorDarkRed,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Navigation(
                                        coordinates.latitude,
                                        coordinates.longitude)),
                              );
                            },
                          ),
                          // FlatButton(
                          //   child: Text('Common routes',style: style.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold)),
                          //   color: colorDarkRed,
                          //   onPressed: commonRoutes,
                          // ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
