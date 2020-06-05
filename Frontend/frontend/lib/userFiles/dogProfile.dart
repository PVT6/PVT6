import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/friendsAndContacts/friendsPage.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:frontend/userFiles/profile.dart';
import '../dog.dart';

class DogProfile extends StatefulWidget {
  final Dog dog;

  DogProfile(this.dog) : super() {}

  final String title = "Maps Demo";

//String name, String age, String weight, String breed
  @override
  DogProfileState createState() => DogProfileState(this.dog);
}

class DogProfileState extends State<DogProfile> {
  Dog dog;
  Image dogPic;
  DogProfileState(Dog dog) {
    this.dog = dog;
  }

  @override
  void initState() {
    _asyncMethod(widget.dog);
    setState(() {
      dogPic = widget.dog.dogPic;
    });

    super.initState();
  }

  Future<void> _asyncMethod(Dog d) async {
    await d.getPicture();
    print("ger");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: colorBeige,
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [colorDarkRed, colorBeige, colorDarkRed],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                          height: double.infinity,
                          width: 380,
                          margin: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 10.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              //child:
                              //Image.asset("BrewDog.jpg", fit: BoxFit.cover),
                              child: widget.dog.dogPic != null
                                  ? FittedBox(
                                      child: dogPic,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "logopurplepink.png") //widget.dog.dogPic
                              )),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text(widget.dog.breed,
                              style: style.copyWith(
                                fontSize: 16,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.dog.name.toString(),
                      style: style.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 280,
                    height: 80,
                    child: Text(
                      widget.dog.description,
                      style: style.copyWith(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Weight: ",
                          style: style.copyWith(
                            color: colorDarkRed,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.dog.weight + "kg",
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Height: ",
                          style: style.copyWith(
                            color: colorDarkRed,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.dog.height + "cm",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          " Age: ",
                          style: style.copyWith(
                            color: colorDarkRed,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.dog.age + "y.o",
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                SizedBox(height: 10.0),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: colorDarkBeige,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileEightPage()));
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                color: colorDarkRed,
                              ),
                              Text("Owners Profile",
                                  style: TextStyle(fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
