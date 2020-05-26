class contactsModel {
  int id;
  List<User> user;

  contactsModel({this.id, this.user});

  contactsModel.fromJson(Map<String, dynamic> json) {
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
  Null position;
  List<OwnedDog> ownedDog;

  User(Set set, 
      {this.id,
      this.name,
      this.email,
      this.savedRoutes,
      this.phoneNumber,
      this.position,
      this.ownedDog});

  User.fromJson(Map<String, dynamic> json) {
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
    position = json['position'];
    if (json['ownedDog'] != null) {
      ownedDog = new List<OwnedDog>();
      json['ownedDog'].forEach((v) {
        ownedDog.add(new OwnedDog.fromJson(v));
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
    data['position'] = this.position;
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

class OwnedDog {
  int id;
  String name;
  String age;
  String weight;
  String race;

  OwnedDog({this.id, this.name, this.age, this.weight, this.race});

  OwnedDog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    weight = json['weight'];
    race = json['race'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['race'] = this.race;
    return data;
  }
}