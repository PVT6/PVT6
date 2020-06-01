import 'package:flutter/widgets.dart';
import 'package:frontend/userFiles/ImageConverter.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/userFiles/user.dart' as userlib;

class Dog {
  int id;
  String name = "";
  String age = "";
  String height = "";
  String weight = "";
  String description = "";
  String gender = "";
  String breed = "";
  Image dogPic;

  Dog(int i,
      {this.id,
      this.name,
      this.age,
      this.height,
      this.weight,
      this.description,
      this.gender,
      this.breed});

  Dog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    height = json['height'];
    weight = json['weight'];
    description = json['description'];
    gender = json['gender'];
    breed = json['race'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['description'] = this.description;
    data['gender'] = this.gender;
    data['race'] = this.breed;
    return data;
  }

  getPicture() async {
    var url = 'https://group6-15.pvt.dsv.su.se/dog/getPicture?id=${this.id}';
    var response = await http.get(Uri.parse(url));
    if (response.body != "none" && response.statusCode == 200)
      this.dogPic = await imageFromBase64String(response.body);
  }
}
