import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

class ImageConverter {

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

String base64StringFromImage(File image){
  
}

}