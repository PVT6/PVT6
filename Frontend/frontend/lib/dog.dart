class Dog {
  int id;
  String name;
  String age;
  String weight;
  String breed;

  Dog({this.id, this.name, this.age, this.weight, this.breed});

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
}