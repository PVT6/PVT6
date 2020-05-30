

import 'package:flutter/widgets.dart';
import 'package:frontend/userFiles/ImageConverter.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/userFiles/user.dart' as userlib;
class Dog {
  int id;
  String name;
  String age;
  String weight;
  String breed;
  Image dogPic;

  Dog(int i, {this.id, this.name, this.age, this.weight, this.breed});

  Dog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    weight = json['weight'];
    breed = json['race'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['race'] = this.breed;
    return data;
  }

  getPicture() async {
    var url = 'https://group6-15.pvt.dsv.su.se/dog/getPicture?id=${this.id}';
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if(response.body != "" && response.statusCode == 200)
      this.dogPic = await imageFromBase64String(response.body);
    
  }
}