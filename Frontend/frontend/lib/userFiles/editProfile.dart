import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/friendsAndContacts/addContactPage.dart';
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

  @override
  Widget build(BuildContext context) {
   TextEditingController name = new TextEditingController(text: userlib.name);
   TextEditingController email = new TextEditingController(text: userlib.email);
   TextEditingController phone = new TextEditingController(text: userlib.phone);
    return new Scaffold(
      appBar: new AppBar(title: const Text('Edit Profile', style: TextStyle(color: colorPeachPink),),
      backgroundColor: colorPurple,
      actions: <Widget>[
        new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
            child: new MaterialButton(
<<<<<<< HEAD
              child: new Text('Save', style: TextStyle(color: colorPeachPink, fontWeight: FontWeight.bold)),
              onPressed: () {
=======
              child: new Text('Save'),
              onPressed: () async {
                var url =
                        'https://group6-15.pvt.dsv.su.se/user/update';
                    var response = await http.post(Uri.parse(url), body: {
                      'name': name.text,
                      'email': email.text,
                      'phone': phone.text,
                      'uid': userlib.uid
                    });
                    if (response.statusCode == 200) {
                      Navigator.of(context).pop();
                      
                    } else {
                      // ERROR MEDELANDE HÄR
                    }
                
>>>>>>> master
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
                  controller: name,
                  decoration: const InputDecoration(labelText: "First Name"),
<<<<<<< HEAD
                  style: TextStyle(fontWeight: FontWeight.bold),
=======
               
>>>>>>> master
                ),
              ),
              new Container(
                child: new TextField(
<<<<<<< HEAD
                  decoration: const InputDecoration(labelText: "Last Name"),
                  style: TextStyle(fontWeight: FontWeight.bold)
=======
                  controller: name ,
                  decoration: const InputDecoration(labelText: "Last Name", ),
                
>>>>>>> master
                ),
              ),
              new Container(
                child: new TextField(
                  controller: email ,
                  decoration: const InputDecoration(
<<<<<<< HEAD
                      labelText: "Email", hintText: "abc@gmail.com"),
                      style: TextStyle(fontWeight: FontWeight.bold) //userData // Måste vara en const så går inte
=======
                      labelText: "Email", ), //userData // Måste vara en const så går inte
>>>>>>> master
                ),
              ),
              new Container(
                child: new TextField(
                  controller: phone,
                  decoration: const InputDecoration(
<<<<<<< HEAD
                      labelText: "Phonenumber", hintText: "070 XXX XX XX"),
                      style: TextStyle(fontWeight: FontWeight.bold) //userData  // Måste vara en const så går inte
=======
                      labelText: "Phonenumber", ), //userData  // Måste vara en const så går inte
>>>>>>> master
                ),
              ),
            ],
          ))),
    );
  }
}