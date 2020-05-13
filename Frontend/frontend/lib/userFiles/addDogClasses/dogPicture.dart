import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/friendsAndContacts/addContactPage.dart';
import 'package:image_picker/image_picker.dart';

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
      backgroundColor: colorLighterPink,
      appBar: AppBar(
        leading: Icon(Icons.verified_user),
        elevation: 0,
        title: Text('Add Pictures'),
        backgroundColor: colorPurple,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                child: Image.asset("logopurplepink.png"),
              ),
              FlatButton(
                child: Text(
                  "Add a picture of your dog: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                color: colorPurple,
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
                    color: colorPurple,
                  )
                : Image.file(File(_path)),
          )
        ],
      ),
    );
  }
}