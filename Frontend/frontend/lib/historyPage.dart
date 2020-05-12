import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'tempDialog.dart';
import 'package:frontend/browseDogParks.dart';
import 'package:frontend/friendsAndContacts/contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/settings.dart';
import 'package:frontend/userFiles/profile.dart';

class RoutePickerTab2 extends StatefulWidget {
  const RoutePickerTab2({
    Key key,
  }) : super(key: key);
  @override
  _RoutePickerTab2 createState() => _RoutePickerTab2();
}

class _RoutePickerTab2 extends State<RoutePickerTab2> {
  final AuthService _auth = AuthService();
  List<String> litems = [
    "Årsta, Stockholm",
    "Globen, Johanneshov",
    "Odenplan, Stockholm",
    "Horsntull, Stockholm",
    "Årsta, Stockholm",
    "Globen, Johanneshov",
    "Odenplan, Stockholm",
    "Horsntull, Stockholm",
    "Årsta, Stockholm",
    "Globen, Johanneshov",
    "Odenplan, Stockholm",
    "Horsntull, Stockholm",
    "Årsta, Stockholm",
    "Globen, Johanneshov",
    "Odenplan, Stockholm",
    "Horsntull, Stockholm",
    "Årsta, Stockholm",
    "Globen, Johanneshov",
    "Odenplan, Stockholm",
    "Horsntull, Stockholm",
    "Årsta, Stockholm",
    "Globen, Johanneshov",
    "Odenplan, Stockholm",
    "Horsntull, Stockholm",
    "Årsta, Stockholm",
    "Globen, Johanneshov",
    "Odenplan, Stockholm",
    "Horsntull, Stockholm",
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
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(height: 90),
                        MaterialButton(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: colorPurple,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    BorderedText(
                      strokeWidth: 6.0,
                      strokeColor: colorPurple,
                      child: Text('Search History',
                          style: TextStyle(
                              color: colorPeachPink,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 50),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 20),
                        Text('Latest search:',
                            style: TextStyle(
                              color: colorPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    Container(
                      width: 400,
                      height: 520,
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
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.grey)),
                            color: Colors.grey,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Select'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          RaisedButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                            color: Colors.red,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Delete'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ))),
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
