import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


Future<Image> imageFromBase64String(String base64String) async {
  // var url = 'https://group6-15.pvt.dsv.su.se/dog/getPicture?id=202';
  // var response = await http.get(Uri.parse(url));
  return Image.memory(base64Decode(base64String));
}

Future<String> base64StringFromImage(String image) async {


  final bytes = await Io.File(image).readAsBytes();

  String img64 = base64Encode(bytes);
  //  var url = 'https://group6-15.pvt.dsv.su.se/dog/setPicture';

  //       var response = await http.post(Uri.parse(url),
  //           body: {'id': "202" , 'base64': img64});
  //       print(response.statusCode);
  //https://group6-15.pvt.dsv.su.se/dog/getPicture?id=202
  return img64;
}
