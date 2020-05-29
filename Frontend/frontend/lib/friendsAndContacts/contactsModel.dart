import '../dog.dart';

class ContactsModel {
  int id;
  List<User> user;

  ContactsModel({this.id, this.user});

  ContactsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['user'] != null) {
      user = new List<User>();
      json['user'].forEach((v) {
        user.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  List<SavedRoutes> savedRoutes;
  String phoneNumber;
  Position position;
  List<Dog> ownedDog;

  User(Set set, 
      {this.id,
      this.name,
      this.email,
      this.savedRoutes,
      this.phoneNumber,
      this.position,
      this.ownedDog});

 User.fromJson(Map<String, dynamic> json) {
   print(json.runtimeType);
    id = json['id'];
    name = json['name'];
    email = json['email'];
    if (json['savedRoutes'] != null) {
      savedRoutes = new List<SavedRoutes>();
      json['savedRoutes'].forEach((v) {
        savedRoutes.add(new SavedRoutes.fromJson(v));
      });
    }
    phoneNumber = json['phoneNumber'];
      position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
    if (json['ownedDog'] != null) {
      ownedDog = new List<Dog>();
      json['ownedDog'].forEach((v) {
        ownedDog.add(new Dog.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.savedRoutes != null) {
      data['savedRoutes'] = this.savedRoutes.map((v) => v.toJson()).toList();
    }
    data['phoneNumber'] = this.phoneNumber;
    if (this.position != null) {
      data['position'] = this.position.toJson();
    }
    if (this.ownedDog != null) {
      data['ownedDog'] = this.ownedDog.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SavedRoutes {
  int id;
  String name;
  String distans;

  SavedRoutes({this.id, this.name, this.distans});

  SavedRoutes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    distans = json['distans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['distans'] = this.distans;
    return data;
  }
}
class Position {
  double x;
  double y;

  Position({this.x, this.y});

  Position.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}
