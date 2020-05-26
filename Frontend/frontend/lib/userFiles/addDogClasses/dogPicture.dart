import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/friendsAndContacts/addContactPage.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:image_picker/image_picker.dart';

import '../../customAppBar.dart';
import '../addDogTest.dart';

class DogPictures extends StatefulWidget {
  const DogPictures({Key key}) : super(key: key);

  @override
  DogPicturesState createState() => DogPicturesState();
}

class DogPicturesState extends State<DogPictures> {
  String _path = null;

  void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _path = file.path;
      dogPicture = file.path;
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
    return Scaffold(
        backgroundColor: colorBeige,
        body: Column(children: <Widget>[
          GradientAppBar(
            "Dog Picture",
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 80,
                    child: Image.asset("logoprototype.png"),
                  ),
                  SizedBox(width: 20),
                  RaisedButton(
                    elevation: 6.0,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.add_a_photo, color: colorDarkRed,),
                        Text(
                          "     Add Picture       ",
                          style: style.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    color: colorLightRed,
                    onPressed: () {
                      _showOptions(context);
                    },
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                width: 400,
                height: 250,
                child: _path == null
                    ? Icon(
                        Icons.photo,
                        size: 200,
                        color: colorDarkRed,
                      )
                    : Image.file(File(_path)),
              )
            ],
          ),
        ]));
  }
}
