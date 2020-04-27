import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:frontend/MySignInPage.dart';
import 'package:frontend/services/auth.dart';

import 'main.dart';
import 'editProfile.dart';

class Settings extends StatefulWidget {
  Settings() : super();

  final String title = "Maps Demo";

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  // final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
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
        backgroundColor: _dark ? null : Colors.blue,
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: _dark ? Colors.white : Colors.black),
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
                  colors: [Colors.blue, Colors.blue.shade200])),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Colors.blue,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()),
                          );
                          //open edit profile
                        },
                        title: Text(
                          "Namn Efternamn",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage:
                              new AssetImage('assets/googleLoginMini.png'),
                        ),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.white,
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
                              color: Colors.blue,
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
                              color: Colors.blue,
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
                              color: Colors.blue,
                            ),
                            title: Text("Map Settings"),
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
                      activeColor: Colors.blue,
                      contentPadding: const EdgeInsets.all(0),
                      value: true,
                      title: Text("Share Location With Friends"),
                      onChanged: (val) {},
                    ),
                    SwitchListTile(
                      activeColor: Colors.blue,
                      contentPadding: const EdgeInsets.all(0),
                      value: false,
                      title: Text("Enable Emergancy Button"),
                      onChanged: (val) {},
                    ),
                    SwitchListTile(
                      activeColor: Colors.blue,
                      contentPadding: const EdgeInsets.all(0),
                      value: true,
                      title: Text("Enable Notifications"),
                      onChanged: (val) {},
                    ),
                    SwitchListTile(
                      activeColor: Colors.blue,
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
                    color: Colors.red,
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
                    color: Colors.white,
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

// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class AddDog extends StatefulWidget {
//   AddDog() : super();

//   final String title = "Maps Demo";

//   @override
//   AddDogState createState() => AddDogState();
// }

// class AddDogState extends State<AddDog> {
//   final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

//   List _sex = [
//     "Male",
//     "Female",
//   ];

//   List<DropdownMenuItem<String>> _dropDownMenuItemsSex;
//   String _currentSex;

//     List _cities =
//   ["Yes", "No"];

//   List<DropdownMenuItem<String>> _dropDownMenuItems;
//   String _currentCity;

//   @override
//   void initState() {
//     _dropDownMenuItemsSex = getDropDownMenuItemsSex();
//     _currentSex = _dropDownMenuItemsSex[0].value;
//       _dropDownMenuItems = getDropDownMenuItems();
//     _currentCity = _dropDownMenuItems[0].value;
//     super.initState();
//   }
//     List<DropdownMenuItem<String>> getDropDownMenuItems() {
//     List<DropdownMenuItem<String>> items = new List();
//     for (String city in _cities) {
//       items.add(new DropdownMenuItem(
//           value: city,
//           child: new Text(city)
//       ));
//     }
//     return items;
//   }

//   List<DropdownMenuItem<String>> getDropDownMenuItemsSex() {
//     List<DropdownMenuItem<String>> items = new List();
//     for (String sex in _sex) {
//       // here we are creating the drop down menu items, you can customize the item right here
//       // but I'll just use a simple text for this
//       items.add(new DropdownMenuItem(value: sex, child: new Text(sex)));
//     }
//     return items;
//   }
//   void changedDropDownItem(String selectedCity) {
//     setState(() {
//       _currentCity = selectedCity;
//     });
//   }


//   void changedDropDownItemSex(String selectedSex) {
//     print("Selected city $selectedSex, we are going to refresh the UI");
//     setState(() {
//       _currentSex = selectedSex;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         body: SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           ProfileHeader(
//             avatar: new AssetImage("profilePH.png"),
//             coverImage: new AssetImage("backgroundStockholm.png"),
//             actions: <Widget>[
//               //Row med items

//               SizedBox(
//                 width: 230,
//               ),
//               MaterialButton(
//                 color: Colors.white,
//                 shape: CircleBorder(),
//                 elevation: 0,
//                 child: Icon(Icons.photo),
//                 onPressed: () {
//                 },
//               ),
//             ],
//           ),
//           Column(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Icon(Icons.wrap_text),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   SizedBox(
//                     width: 250,
//                     height: 40,
//                     child: TextField(
//                       decoration: InputDecoration(
//                           labelText: "Name", hasFloatingPlaceholder: true),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: <Widget>[
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Icon(Icons.pets),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   SizedBox(
//                     width: 250,
//                     height: 40,
//                     child: TextField(
//                       decoration: InputDecoration(
//                           labelText: "Type", hasFloatingPlaceholder: true),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: <Widget>[
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Icon(Icons.pets),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   SizedBox(
//                     width: 250,
//                     height: 40,
//                     child: TextField(
//                       decoration: InputDecoration(
//                           labelText: "Breed", hasFloatingPlaceholder: true),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: <Widget>[
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Icon(Icons.person),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text("Gender"),
//                   SizedBox(
//                     width: 14,
//                   ),
//                   DropdownButton(
//                     value: _currentSex,
//                     items: _dropDownMenuItemsSex,
//                     onChanged: changedDropDownItemSex,
//                   ),
//                 ],
//               ),
//               Row(
//                 children: <Widget>[
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Icon(Icons.toys),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text("Neutered"),
//                   SizedBox(width: 27,),
//                 DropdownButton(
//                 value: _currentCity,
//                 items: _dropDownMenuItems,
//                 onChanged: changedDropDownItem,
//               )
                  
//                 ],
//               ),
//               Row(
//                 children: <Widget>[
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Icon(FontAwesomeIcons.weight),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   SizedBox(
//                     width: 250,
//                     height: 40,
//                     child: TextField(
//                       decoration: InputDecoration(
//                           labelText: "Weight", hasFloatingPlaceholder: true),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: <Widget>[
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Icon(FontAwesomeIcons.textHeight),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   SizedBox(
//                     width: 250,
//                     height: 40,
//                     child: TextField(
//                       decoration: InputDecoration(
//                           labelText: "Height", hasFloatingPlaceholder: true),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: <Widget>[
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Icon(Icons.pin_drop),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   SizedBox(
//                     width: 250,
//                     height: 40,
//                     child: TextField(
//                       decoration: InputDecoration(
//                           labelText: "Chip ID", hasFloatingPlaceholder: true),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     ));
//   }
// }

// class ProfileHeader extends StatelessWidget {
//   final ImageProvider<dynamic> coverImage;
//   final ImageProvider<dynamic> avatar;
//   final List<Widget> actions;

//   const ProfileHeader(
//       {Key key, @required this.coverImage, @required this.avatar, this.actions})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Ink(
//           height: 200,
//           decoration: BoxDecoration(
//             color: Colors.lightBlue,
//           ),
//         ),
//         Ink(
//           height: 200,
//           decoration: BoxDecoration(
//             color: Colors.black38,
//           ),
//         ),
//         if (actions != null)
//           Container(
//             width: double.infinity,
//             height: 200,
//             padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
//             alignment: Alignment.bottomRight,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: actions,
//             ),
//           ),
//         Container(
//           width: double.infinity,
//           margin: const EdgeInsets.only(top: 140),
//           child: Stack(
//             alignment: Alignment.center,
//             children: <Widget>[
//               Avatar(
//                 image: avatar,
//                 radius: 60,
//                 backgroundColor: Colors.white,
//                 borderColor: Colors.grey.shade300,
//                 borderWidth: 4.0,
//               ),
//               Row(
//                 children: <Widget>[
//                   SizedBox(width: 120),
//                   IconButton(
//                     icon: Icon(FontAwesomeIcons.camera),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class Avatar extends StatelessWidget {
//   final ImageProvider<dynamic> image;
//   final Color borderColor;
//   final Color backgroundColor;
//   final double radius;
//   final double borderWidth;

//   const Avatar(
//       {Key key,
//       @required this.image,
//       this.borderColor = Colors.grey,
//       this.backgroundColor,
//       this.radius = 30,
//       this.borderWidth = 5})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: radius + borderWidth,
//       backgroundColor: borderColor,
//       child: CircleAvatar(
//         radius: radius,
//         backgroundColor: backgroundColor != null
//             ? backgroundColor
//             : Theme.of(context).primaryColor,
//         child: CircleAvatar(
//           radius: radius - borderWidth,
//           backgroundImage: image,
//         ),
//       ),
//     );
//   }
// }

