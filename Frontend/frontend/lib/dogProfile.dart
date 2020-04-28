import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:frontend/profile.dart';
import 'package:frontend/user.dart';

import 'addPet.dart';

class DogProfile extends StatefulWidget {
  String age;

  String breed;
  String name;
  String weight;

  
  DogProfile(String name, String age, String weight, String breed) : super() {
    this.age = age;
    this.name = name;
    this.weight = weight;
    this.breed = breed;
  }

  

  final String title = "Maps Demo";
 
//String name, String age, String weight, String breed
  @override
  DogProfileState createState() => DogProfileState(this.name, this.age, this.weight, this.breed);
}

class DogProfileState extends State<DogProfile> {
  String age;
  String breed;
  String name;
  String weight;
  DogProfileState(String name, String age, String weight, String breed){
    this.age = age;
    this.name = name;
    this.breed = breed;
    this.weight = weight;
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SizedBox(
                        height: 300.0,
                        child: Carousel(
                          boxFit: BoxFit.cover,
                          autoplay: false,
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 1000),
                          dotSize: 6.0,
                          dotIncreasedColor: Color(0xFFFF335C),
                          dotBgColor: Colors.transparent,
                          dotPosition: DotPosition.topRight,
                          dotVerticalPadding: 10.0,
                          showIndicator: true,
                          indicatorBgPadding: 7.0,
                          images: [
                            Image.asset("BrewDog.jpg"),
                            Image.asset("ormingesHundrastgard.jpg"),
                            Image.asset("HimmelskaHundar.jpg"),
                            Image.asset("LeBistro.jpg"),
                          ],
                        )),
                    Positioned(
                      bottom: 20.0,
                      left: 20.0,
                      right: 20.0,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 280,),
                          MaterialButton(
                            color: Colors.white,
                            shape: CircleBorder(),
                            elevation: 0,
                            child: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddDog()),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            name,
                            style: Theme.of(context).textTheme.title,
                          ),
                          SizedBox(
                            width: 200,
                          ),
                          Icon(
                            Icons.pets,
                            color: Colors.blue,
                          ),
                          Text(
                            breed,
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.pin_drop,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Vällingby, Stockholm",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 36,
                      ),
                      Text(
                        age,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 105.0,
                      ),
                      Text(
                        weight,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 105.0,
                      ),
                      Text(
                        "51cm",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Age",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(
                        width: 90.0,
                      ),
                      Text(
                        "Weight",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(
                        width: 90.0,
                      ),
                      Text(
                        "Height",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Ella is a 4 year old pitbull born and raised in Stockholm. She is currently looking for other medium sized dogs who are interested in a playdate.",
                    textAlign: TextAlign.justify,
                  ),
                  Row(
                    children: <Widget>[
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Text('Owners Profile'),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileEightPage()),
                              );
                            },
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
