import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

class ImageConverter {

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

String base64StringFromImage(Image image){
  final bytes = Io.File('image').readAsBytesSync();
  String base64String = base64Encode(bytes);
  return base64String;
}

}