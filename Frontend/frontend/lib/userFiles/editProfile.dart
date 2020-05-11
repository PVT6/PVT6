import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/friendsAndContacts/addContactPage.dart';
import 'user.dart' as userlib;

class EditProfile extends StatefulWidget {
  EditProfile() : super();

  final String title = "Maps Demo";

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    var email = userlib.email;
    return new Scaffold(
      appBar: new AppBar(title: const Text('Edit Profile', style: TextStyle(color: colorPeachPink),),
      backgroundColor: colorPurple,
      actions: <Widget>[
        new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
            child: new MaterialButton(
              child: new Text('Save', style: TextStyle(color: colorPeachPink, fontWeight: FontWeight.bold)),
              onPressed: () {
                //spara ändringar, kolla ner vid contacts hur man gör
              },
            ))
      ]),
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
              new Container(
                child: new TextField(
                  decoration: const InputDecoration(labelText: "First Name"),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Container(
                child: new TextField(
                  decoration: const InputDecoration(labelText: "Last Name"),
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
              ),
              new Container(
                child: new TextField(
                  decoration: const InputDecoration(
                      labelText: "Email", hintText: "abc@gmail.com"),
                      style: TextStyle(fontWeight: FontWeight.bold) //userData // Måste vara en const så går inte
                ),
              ),
              new Container(
                child: new TextField(
                  decoration: const InputDecoration(
                      labelText: "Phonenumber", hintText: "070 XXX XX XX"),
                      style: TextStyle(fontWeight: FontWeight.bold) //userData  // Måste vara en const så går inte
                ),
              ),
            ],
          ))),
    );
  }
}