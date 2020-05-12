class SentRequest {
  String status;
  Sender sender;
  Sender receiver;

  SentRequest({this.status, this.sender, this.receiver});

  SentRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    receiver =
        json['receiver'] != null ? new Sender.fromJson(json['receiver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    if (this.receiver != null) {
      data['receiver'] = this.receiver.toJson();
    }
    return data;
  }
}

class Sender {
  int id;
  String name;
  String email;
  String phoneNumber;
  Null position;

  Sender({this.id, this.name, this.email, this.phoneNumber, this.position});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['position'] = this.position;
    return data;
  }
}