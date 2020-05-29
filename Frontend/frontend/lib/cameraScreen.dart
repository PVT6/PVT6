import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:frontend/userFiles/ImageConverter.dart';

const colorPurple = const Color(0xFF82658f);
const colorPeachPink = const Color(0xFFffdcd2);
const colorLighterPink = const Color(0xFFffe9e5);

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraScreen(this.cameras);

  @override
  CameraScreenState createState() {
    return new CameraScreenState();
  }
}

class CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  String imagePath;

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> takePicture() async {
    final Directory extDir = await getExternalStorageDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
  }

  void logError(String code, String message) =>
      print('Error: $code\nError Message: $message');

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) _takePhoto();
      }
    });
  }

  Future<void> _takePhoto() async {
    GallerySaver.saveImage(imagePath);
    showPhotoTakenDialog(context);
  }

  @override
  void initState() {
    super.initState();
    controller = new CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  showPhotoTakenDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: colorPeachPink,
      title: Text(
        "Picture Saved",
        style: TextStyle(
          fontFamily: 'Hipster Script W00 Regular',
          fontSize: 28,
        ),
      ),
      content: Container(
        width: 200,
        height: 230,
        child: Column(
          children: <Widget>[
            SizedBox(
                width: 200,
                height: 160,
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                )),
            Text(
                "You can add this new Photo to your own profile or one of your dogs!"),
          ],
        ),
      ),
      actions: [
        FlatButton(
          color: Colors.green,
          onPressed: (() {
              
              var s = base64StringFromImage( Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                ));
                
                print(s);
                
              ;
          }()),
        
          
           //Navigator.pop(context),
          child: Text("Ok"),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    if (!controller.value.isInitialized) {
      return new Container();
    }
    return new Transform.scale(
        scale: controller.value.aspectRatio / deviceRatio,
        child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                onTakePictureButtonPressed();
                // if (imagePath != null) {
                //   _takePhoto();
                // }
                // setState(() {
                //   _takePhoto();
                // });
              },
              tooltip: "Centre FAB",
              child: Container(
                margin: EdgeInsets.all(15.0),
                child: Icon(Icons.camera_alt),
              ),
              elevation: 4.0,
            ),
            body: Center(
                child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: new CameraPreview(controller),
            ))));
  }
}
