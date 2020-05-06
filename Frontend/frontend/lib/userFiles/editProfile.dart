import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
      appBar: new AppBar(title: const Text('Edit Profile'), actions: <Widget>[
        new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
            child: new MaterialButton(
              child: new Text('Save'),
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
                  colors: [Colors.green, Colors.blue])),
          child: Form(
              child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new Container(
                child: new TextField(
                  decoration: const InputDecoration(labelText: "First Name"),
                ),
              ),
              new Container(
                child: new TextField(
                  decoration: const InputDecoration(labelText: "Last Name"),
                ),
              ),
              new Container(
                child: new TextField(
                  decoration: const InputDecoration(
                      labelText: "Email", hintText: "abc@gmail.com"), //userData // Måste vara en const så går inte
                ),
              ),
              new Container(
                child: new TextField(
                  decoration: const InputDecoration(
                      labelText: "Phonenumber", hintText: "070 XXX XX XX"), //userData  // Måste vara en const så går inte
                ),
              ),
            ],
          ))),
    );
  }
}