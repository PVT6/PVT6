import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/friendsAndContacts/addContactPage.dart';
import 'package:image_picker/image_picker.dart';
import 'user.dart' as userlib;
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  EditProfile() : super();

  final String title = "Maps Demo";

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String _path = null;

  void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _path = file.path;
    });
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 60,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: _showPhotoLibrary,
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library")),
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController name = new TextEditingController(text: userlib.name);
    TextEditingController email =
        new TextEditingController(text: userlib.email);
    TextEditingController phone =
        new TextEditingController(text: userlib.phone);
    return new Scaffold(
      appBar: new AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: colorPeachPink),
        ),
        backgroundColor: colorPurple,
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [colorLighterPink, colorPeachPink])),
          child: Form(
              child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              Container(
                height: 150,
                width: 150,
                child: Row(
                  children: <Widget>[
                    _path == null
                        ? Image.asset("LeBistro.jpg", fit: BoxFit.cover,)
                        : Image.file(File(_path), fit: BoxFit.cover,),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.edit,
                      ),
                      onPressed: () {
                        _showOptions(context);
                      },
                    )
                  ],
                ),
              ),
              new Container(
                child: new TextField(
                  controller: name,
                  decoration: const InputDecoration(labelText: "First Name"),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Container(
                child: new TextField(
                    controller: email,
                    decoration: const InputDecoration(
                        labelText: "Email", hintText: "abc@gmail.com"),
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              new Container(
                child: new TextField(
                    controller: phone,
                    decoration: const InputDecoration(
                        labelText: "Phonenumber", hintText: "070 XXX XX XX"),
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              FlatButton(
                color: colorPurple,
                onPressed: () async {
                  var url = 'https://group6-15.pvt.dsv.su.se/user/update';
                  var response = await http.post(Uri.parse(url), body: {
                    'name': name.text,
                    'email': email.text,
                    'phone': phone.text,
                    'uid': userlib.uid
                  });
                  print(userlib.uid);
                  print(response.body);
                  if (response.statusCode == 200) {
                    Navigator.of(context).pop();
                    var url =
                        'https://group6-15.pvt.dsv.su.se/user/find?uid=${userlib.uid}';
                    var response = await http.get(Uri.parse(url));
                    if (response.body != "") {
                      var user = json.decode(response.body);
                      userlib.setName(user['name']);
                      userlib.setPhone(user['phoneNumber']);
                      userlib.setEmail(user['email']);
                      userlib.setLogin(true);
                    }
                  } else {
                    // ERROR MEDELANDE HÄR
                  }
                },
                child: Text("Update", style: TextStyle(fontSize: 17)),
              ),
            ],
          ))),
    );
  }
}
