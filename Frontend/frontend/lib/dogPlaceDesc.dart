import 'package:flutter/material.dart';
import 'package:frontend/friendsAndContacts/addContactPage.dart';
import 'package:frontend/mapFiles/temp.dart';
import 'package:frontend/mapFiles/temp2.dart';
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
  

  DogPlaceDesc2(this.image, this.rating, this.location, this.title, this.desc,
       this.directions, this.commonRoutes, this.coordinates);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPurple,
        title: Text('Description', style: TextStyle(color : colorPeachPink),),
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
                        child: Text(location),
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.title,
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
                      Text("20.2k"),
                      SizedBox(
                        width: 16.0,
                      ),
                      Icon(Icons.comment),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text("2.2k"),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    desc,
                    textAlign: TextAlign.justify,
                  ),
                  Row(
                    children: <Widget>[
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Text('View on Map'),
                            color: colorPurple,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Mapbox(coordinates)),
                              );
                            },
                          ),
                          FlatButton(
                            child: Text('Directions'),
                            color: colorPurple,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Navigation(coordinates.latitude, coordinates.longitude)),
                              );
                            },
                          ),
                          FlatButton(
                            child: Text('Common routes'),
                            color: colorPurple,
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
