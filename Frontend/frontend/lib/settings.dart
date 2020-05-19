import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/userFiles/editProfile.dart';
import 'package:frontend/userFiles/user.dart' as userlib;

import 'friendsAndContacts/addContactPage.dart';



class Settings extends StatefulWidget {
  Settings() : super();

  final String title = "Maps Demo";

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();
  bool _dark;

  @override
  void initState() {
    super.initState();
    _dark = false;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : colorPurple,
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : colorPeachPink),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: _dark ? Colors.white : colorPeachPink),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.moon),
              onPressed: () {
                setState(() {
                  _dark = !_dark;
                });
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [colorLighterPink, colorPeachPink])),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()),
                          );
                        
                        },
                        title: Text(
                          userlib.name, //userData
                          style: TextStyle(
                            color: colorPurple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage:
                              new AssetImage('assets/profilePH.png'),
                        ),
                        trailing: Icon(
                          Icons.edit,
                          color: colorPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.lock_outline,
                              color: colorPurple,
                            ),
                            title: Text("Privacy Settings"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              //skapa ny sida
                            },
                          ),
                          _buildDivider(),
                          ListTile(
                            leading: Icon(
                              FontAwesomeIcons.language,
                              color: colorPurple,
                            ),
                            title: Text("Change Language"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              //ändra språk
                            },
                          ),
                          _buildDivider(),
                          ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: colorPurple,
                            ),
                            title: Text("Map Settings"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              //open change location
                            },
                          ),
                          _buildDivider(),
                          ListTile(
                            leading: Icon(
                              Icons.settings,
                              color: colorPurple,
                            ),
                            title: Text("Placeholder"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              //open change location
                            },
                          ),
                          _buildDivider(),
                          ListTile(
                            leading: Icon(
                              Icons.settings,
                              color: colorPurple,
                            ),
                            title: Text("Placeholder"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              //open change location
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "Options",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SwitchListTile(
                      activeColor: colorPurple,
                      contentPadding: const EdgeInsets.all(0),
                      value: true,
                      title: Text("Share Location With Friends"),
                      onChanged: (val) {},
                    ),
                    SwitchListTile(
                      activeColor: colorPurple,
                      contentPadding: const EdgeInsets.all(0),
                      value: false,
                      title: Text("See Local User On Map"),
                      onChanged: (val) {},
                    ),
                    SwitchListTile(
                      activeColor: colorPurple,
                      contentPadding: const EdgeInsets.all(0),
                      value: true,
                      title: Text("Enable Notifications"),
                      onChanged: (val) {},
                    ),
                    SwitchListTile(
                      activeColor: colorPurple,
                      contentPadding: const EdgeInsets.all(0),
                      value: true,
                      title: Text("Fingerprint login"),
                      onChanged: (val) {},
                    ),
                    const SizedBox(height: 60.0),
                  ],
                ),
              ),
              Positioned(
                bottom: -20,
                left: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorPurple,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: 00,
                left: 00,
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.powerOff,
                    color: colorPeachPink,
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MySignInPage()),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}


