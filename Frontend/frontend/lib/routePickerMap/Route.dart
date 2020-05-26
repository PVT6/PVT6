class SavedRoute {
  int id;
  String name;
  String distans;

  SavedRoute({this.id, this.name, this.distans});

  SavedRoute.fromJson(Map<String, dynamic> json) {
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