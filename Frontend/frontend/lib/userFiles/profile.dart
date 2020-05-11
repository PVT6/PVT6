import 'dart:convert';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/mapFiles/temp.dart';
import 'package:frontend/userFiles/addPet.dart';
import 'package:frontend/userFiles/dogProfile.dart';
import 'package:flutter/cupertino.dart';
import 'user.dart' as userlib;
import 'package:frontend/mapFiles/mapsDemo.dart';
import 'package:http/http.dart' as http;
import '../dog.dart';

class ProfileEightPage extends StatefulWidget {
  ProfileEightPage() : super();

  @override
  ProfileEightPageState createState() => ProfileEightPageState();
}

class ProfileEightPageState extends State<ProfileEightPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> getDogs() async {
    var uid = userlib.uid;
    var url = 'https://group6-15.pvt.dsv.su.se/user/dogs?uid=${uid}';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      dogs = (json.decode(response.body) as List)
          .map((i) => Dog.fromJson(i))
          .toList();
      userDogs = dogs;
    } else {
      // ERROR HÄR
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLighterPink,
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ProfileHeader(
              avatar: new AssetImage("profilePH.png"), //userData
              coverImage: new AssetImage("backgroundStockholm.png"), //userData
              title: userlib.name, //userData
              subtitle: "Dog lover",
              actions: <Widget>[
                //Row med items
                MaterialButton(
                  color: colorPeachPink,
                  shape: CircleBorder(),
                  elevation: 0,
                  child: Icon(Icons.arrow_back, color: colorPurple),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapsDemo()),
                    );
                  },
                ),
                SizedBox(
                  width: 230,
                ),
                MaterialButton(
                  color: colorPeachPink,
                  shape: CircleBorder(),
                  elevation: 0,
                  child: Icon(
                    Icons.pets,
                    color: colorPurple,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddDog()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            UserInfo(),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SKRIVA IN SÅ ATT LISTAN ANVÄNDS

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
              alignment: Alignment.topLeft,
              child: BorderedText(
                strokeWidth: 5.0,
                strokeColor: colorPurple,
                child: Text(
                  "My Dogs",
                  style: TextStyle(
                    color: colorLighterPink,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
              )),
          SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  userDogs != null
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: userDogs?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            Dog c = userDogs?.elementAt(index);
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DogProfile(c)));
                              },
                              leading: (c.name != null && c.name.length > 0)
                                  ? CircleAvatar(
                                      child: Text(
                                          "Bild"), //här kan man lägga bild istället när det ordnats i hundklass
                                    )
                                  : CircleAvatar(child: Text(c.name)),
                              title: Text(c.name + " " + c.breed ?? ""),
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              )),
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: BorderedText(strokeWidth: 6.0,
            strokeColor: colorPurple,
            child : Text(
              "User Information", //userData
              style: TextStyle(
                color: colorLighterPink,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          )),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.my_location, color: colorPurple),
                            title: Text(
                              "Location",
                              style: TextStyle(color: colorPurple),
                            ),
                            subtitle: Text(
                              "Stockholm",
                              style: TextStyle(color: colorPurple),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.email, color: colorPurple),
                            title: Text(
                              "Email",
                              style: TextStyle(color: colorPurple),
                            ),
                            subtitle: Text(
                              userlib.email,
                              style: TextStyle(color: colorPurple),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone, color: colorPurple),
                            title: Text(
                              "Phone",
                              style: TextStyle(color: colorPurple),
                            ),
                            subtitle: Text(
                              userlib.phone,
                              style: TextStyle(color: colorPurple),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.person, color: colorPurple),
                            title: Text(
                              "About Me",
                              style: TextStyle(color: colorPurple),
                            ),
                            subtitle: Text(
                              "I love big fluffy dogs. Proud owner of a Bernese Mountain Dog",
                              style: TextStyle(color: colorPurple),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const ProfileHeader(
      {Key key,
      @required this.coverImage,
      @required this.avatar,
      @required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 60,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key key,
      @required this.image,
      this.borderColor = colorPurple,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: colorPurple,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
        ),
      ),
    );
  }
}
