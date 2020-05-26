
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/browseDogParks.dart';
import 'package:frontend/friendsAndContacts/addContactPage.dart';
import 'package:frontend/friendsAndContacts/contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/settings.dart';
import 'package:frontend/userFiles/profile.dart';

class FriendsFeed extends StatefulWidget {
  FriendsFeed() : super();

  @override
  FriendsFeedState createState() => FriendsFeedState();
}

class FriendsFeedState extends State<FriendsFeed> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [colorLighterPink, colorPeachPink])),
          child: new Column(children: <Widget>[
            SizedBox(height: 20),
            SizedBox(
                height: 80,
                width: double.infinity,
                child: Image.asset(
                  'assets/logopurplepink.png',
                  alignment: Alignment.topRight,
                )),
            BorderedText(
              strokeWidth: 6.0,
              strokeColor: colorPurple,
              child: Text(
                'Friends feed',
                style: TextStyle(
                  color: colorPeachPink,
                  fontWeight: FontWeight.bold,
                  fontSize: 45.0,
                ),
              ),
            ),
            Stack(children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FlatButton.icon(onPressed: () {},
                        icon: Icon(Icons.pin_drop, color: Colors.red),
                        label: Text('Show on map',
                        style: TextStyle(
                          color: colorPurple,
                          fontWeight: FontWeight.bold,
                        ),))
                      ]))
            ]),
                                Image.asset(
                      ('assets/fakefeed.png')
                    ),
          ]),
        )),
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: colorPurple,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                height: 56.0,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: showMenu,
                      icon: Icon(Icons.menu),
                      color: colorPeachPink,
                    ),
                  ],
                ))));
  }

  showMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
              color: colorPurple,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 36,
                ),
                SizedBox(
                    height: (56 * 5).toDouble(),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                          color: colorPeachPink,
                        ),
                        child: Stack(
                          alignment: Alignment(0, 0),
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                              top: -36,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(
                                        color: colorPeachPink, width: 10)),
                                child: Center(
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/logopurplepink.png",
                                      fit: BoxFit.cover,
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      "Profile",
                                      style: TextStyle(color: colorPurple),
                                    ),
                                    leading: Icon(
                                      Icons.person,
                                      color: colorPurple,
                                    ),
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileEightPage()))
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Contacts",
                                      style: TextStyle(color: colorPurple),
                                    ),
                                    leading: Icon(
                                      Icons.contact_phone,
                                      color: colorPurple,
                                    ),
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => Contacts()))
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Settings",
                                      style: TextStyle(color: colorPurple),
                                    ),
                                    leading: Icon(
                                      Icons.settings,
                                      color: colorPurple,
                                    ),
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => Settings()))
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Browse dogparks",
                                      style: TextStyle(color: colorPurple),
                                    ),
                                    leading: Icon(
                                      Icons.pets,
                                      color: colorPurple,
                                    ),
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  BrowseDogParks()))
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Log out",
                                      style: TextStyle(color: colorPurple),
                                    ),
                                    leading: Icon(
                                      Icons.lock,
                                      color: colorPurple,
                                    ),
                                    onTap: () async => {
                                      await _auth.signOut(),
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  MySignInPage()))
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))),
                Container(
                  height: 56,
                  color: colorPurple,
                )
              ],
            ),
          );
        });
  }
}
