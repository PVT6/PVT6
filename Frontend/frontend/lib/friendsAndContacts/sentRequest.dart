import 'package:frontend/friendsAndContacts/contactsModel.dart';

class SentRequest {
  String status;
  Sender sender;
  Receiver receiver;

  SentRequest({this.status, this.sender, this.receiver});

  SentRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null
        ? new Receiver.fromJson(json['receiver'])
        : null;
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

class Sender extends User {
  Sender({id, name, email, savedRoutes, phoneNumber, position, ownedDog})
      : super({id, name, email, savedRoutes, phoneNumber, position, ownedDog});

  Sender.fromJson(json) : super.fromJson(Map<String, dynamic>.from(json));
}

class Receiver extends User {
  Receiver({id, name, email, savedRoutes, phoneNumber, position, ownedDog})
      : super({id, name, email, savedRoutes, phoneNumber, position, ownedDog});

  Receiver.fromJson(json) : super.fromJson(Map<String, dynamic>.from(json));
}
