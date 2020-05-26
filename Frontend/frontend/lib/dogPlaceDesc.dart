import 'package:flutter/material.dart';
import 'package:frontend/friendsAndContacts/addContactPage.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:frontend/mapFiles/temp.dart';
import 'package:latlong/latlong.dart';


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

  DogPlaceDesc2(this.image, this.rating, this.location, this.title, this.desc,
       this.directions, this.commonRoutes, this.coordinates);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDarkBeige,
        title: Text('Description', style: style.copyWith(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(image)),
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
                        child: Text(location, style: style.copyWith(fontSize: 13),),
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {},
                      )
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
                      Text("2.2k",style: style.copyWith(fontSize: 15.0)),
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
                            child: Text('View on Map', style: style.copyWith(fontSize: 14.0,fontWeight: FontWeight.bold)),
                            color: colorDarkRed,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Mapbox(coordinates)),
                              );
                            },
                          ),
                          FlatButton(
                            child: Text('Directions', style: style.copyWith(fontSize: 14.0,fontWeight: FontWeight.bold),),
                            color: colorDarkRed,
                            onPressed: directions,
                          ),
                          FlatButton(
                            child: Text('Common routes',style: style.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold)),
                            color: colorDarkRed,
                            onPressed: commonRoutes,
                          ),
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
