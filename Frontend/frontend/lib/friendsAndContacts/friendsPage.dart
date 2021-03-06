import 'dart:convert';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/friendsAndContacts/contactsModel.dart';
import 'package:frontend/friendsAndContacts/sentRequest.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:frontend/mapFiles/mapPreview.dart';

import 'package:frontend/mapFiles/mapsDemo.dart';
import 'package:frontend/routePickerMap/Route.dart';
import 'package:frontend/userFiles/dogProfile.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/userFiles/user.dart' as userlib;

import '../dog.dart';
import 'package:latlong/latlong.dart' as latlng;

List<User> friends = [];

const colorPurple = const Color(0xFF82658f);
const colorPeachPink = const Color(0xFFffdcd2);
const colorLighterPink = const Color(0xFFffe9e5);
List<SentRequest> sentRequest = [];
List<SentRequest> waitingRequest = [];
Future<void> getInfo() async {
  //sentRequests

  var url =
      'https://group6-15.pvt.dsv.su.se/contacts/sentRequests?uid=${userlib.uid}';
  var response = await http.get(Uri.parse(url));
  sentRequest = (json.decode(response.body) as List)
      .map((i) => SentRequest.fromJson(i))
      .toList();
  print(response.statusCode);

  url =
      'https://group6-15.pvt.dsv.su.se/contacts/waitingRequests?uid=${userlib.uid}';
  response = await http.get(Uri.parse(url));
  waitingRequest = (json.decode(response.body) as List)
      .map((i) => SentRequest.fromJson(i))
      .toList();
  print(response.statusCode);

  url = 'https://group6-15.pvt.dsv.su.se/contacts/all?uid=${userlib.uid}';
  response = await http.get(Uri.parse(url));
  if (response.body != "") {
    final body = json.decode(response.body);

    print("LOAD FRIENDS");
    friends = (json.decode(jsonEncode(body["user"])) as List)
        .map((i) => User.fromJson(i))
        .toList();
    print(response.statusCode);
  } else {
    print("NO FRIENDS");
    friends.clear();
  }
}

class FriendsPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<FriendsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  List<SentRequest> receivingRequests = [];

  @override
  void initState() {
    setInfo();
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  Future<void> setInfo() async {
    await getInfo();
    friends.sort((a, b) => a.name.compareTo(b.name));
  }

  Future<void> getInfo() async {
    //sentRequests

    var url =
        'https://group6-15.pvt.dsv.su.se/contacts/sentRequests?uid=${userlib.uid}';
    var response = await http.get(Uri.parse(url));
    setState(() {
      sentRequest = (json.decode(response.body) as List)
          .map((i) => SentRequest.fromJson(i))
          .toList();
      print(response.statusCode);
    });

    url =
        'https://group6-15.pvt.dsv.su.se/contacts/waitingRequests?uid=${userlib.uid}';
    response = await http.get(Uri.parse(url));
    setState(() {
      waitingRequest = (json.decode(response.body) as List)
          .map((i) => SentRequest.fromJson(i))
          .toList();
      print(response.statusCode);
    });

    url = 'https://group6-15.pvt.dsv.su.se/contacts/all?uid=${userlib.uid}';
    response = await http.get(Uri.parse(url));
    if (response.body != "") {
      final body = json.decode(response.body);

      print("LOAD FRIENDS");
      setState(() {
        friends = (json.decode(jsonEncode(body["user"])) as List)
            .map((i) => User.fromJson(i))
            .toList();
        print(response.statusCode);
      });
    } else {
      print("NO FRIENDS");
      friends.clear();
    }
  }

  cancleRequestAlert(BuildContext context, phone) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    Widget acceptButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green,
      child: MaterialButton(
        minWidth: 100,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          Navigator.of(context).pop();
          var url = 'https://group6-15.pvt.dsv.su.se/contacts/cancleRequests';

          var response = await http
              .post(Uri.parse(url), body: {'uid': userlib.uid, 'phone': phone});
          print(response.statusCode);
          getInfo();
        },
        child: Text("Yes",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text("Friend Request"),
      content: Text("Do you really want to cancle this friend request"),
      actions: [
        cancelButton,
        acceptButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context, phone) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Decline"),
      onPressed: () async {
        var url = 'https://group6-15.pvt.dsv.su.se/contacts/answer';

        var response = await http.post(Uri.parse(url),
            body: {'uid': userlib.uid, 'phone': phone, 'e': 'rejcet'});
        print(response.statusCode);
        getInfo();

        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    Widget acceptButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green,
      child: MaterialButton(
        minWidth: 100,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          var url = 'https://group6-15.pvt.dsv.su.se/contacts/answer';
          var response = await http.post(Uri.parse(url),
              body: {'uid': userlib.uid, 'phone': phone, 'e': 'accept'});
          print(response.statusCode);
          getInfo();
          Navigator.of(context).pop(); // dismiss dialog
        },
        child: Text("Accept",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text("Friend Request"),
      content: Text("This user would like to add you"),
      actions: [
        cancelButton,
        acceptButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getFriendPos(User c) async {
    if (c.position.x != null) {
      final coordinates = new Coordinates(c.position.y, c.position.x);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      return addresses.first.addressLine;
    }
    return "unavailable";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: colorBeige,
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: new Text(
          "Friends Page",
          style: style.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: colorDarkBeige,
        bottom: TabBar(
          unselectedLabelColor: colorPrimaryRed,
          labelColor: colorDarkRed,
          tabs: [
            new Tab(icon: new Icon(Icons.person)),
            new Tab(
              icon: new Icon(Icons.person_add),
            ),
            new Tab(
              icon: new Icon(Icons.search),
            )
          ],
          controller: _tabController,
          indicatorColor: colorDarkRed,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    // Text("My Friendlist", //snyggare font/text behövs
                    // style: TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 18.0,
                    //           letterSpacing: 1.1),),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                friends != null
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: friends?.length ??
                            0, //lägga till vår egen lista på denna bör funka
                        itemBuilder: (BuildContext context, int index) {
                          User c = friends?.elementAt(index);
                          return Card(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProfileInfo(c)));
                                },
                                leading: CircleAvatar(
                                  child: Text("PH",
                                      style: TextStyle(color: Colors.white)),
                                  backgroundColor: colorDarkRed,
                                ),
                                title: Text(c.name ?? "",
                                    style: style.copyWith(fontSize: 18.0)),
                                subtitle: FutureBuilder<dynamic>(
                                  future: getFriendPos(c),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data);
                                    } else {
                                      return Text("Loading");
                                    }
                                  },
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.person_pin,
                                    color: Colors.black,
                                    size: 37,
                                  ),
                                  onPressed: () {
                                    latlng.LatLng coordinates = latlng.LatLng(
                                        c.position.y, c.position.x);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                MapsDemo(coordinates)));
                                  },
                                ),
                              ));
                        },
                      )
                    : Center(
                        child: Text("No friends added",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17)),
                      ),
              ])),
          SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    //titel och Icon här
                  ],
                ),
                Divider(
                  thickness: 3,
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      "Friend requests",
                      style: style.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    waitingRequest != null
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: waitingRequest?.length ??
                                0, //lägga till vår egen lista på denna bör funka
                            itemBuilder: (BuildContext context, int index) {
                              SentRequest c = waitingRequest?.elementAt(index);
                              return Card(
                                  elevation: 8.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: ListTile(
                                      leading: CircleAvatar(child: Text("PH")),
                                      title: Text(c.sender.name ?? ""),
                                      subtitle:
                                          Text(c.sender.phoneNumber ?? ""),
                                      trailing: (() {
                                        IconButton b;

                                        // HÄR BEHÖVS ICONER FÖR WAITING REJECTED OCH ACCEPTED
                                        if (c.status == "WAITING") {
                                          b = IconButton(
                                            icon: Icon(
                                              Icons.person_add,
                                              color: Colors.green,
                                              size: 37,
                                            ),
                                            onPressed: () {
                                              showAlertDialog(context,
                                                  c.sender.phoneNumber);
                                            },
                                          );
                                        } else if (c.status == "ACCEPTED") {
                                          b = IconButton(
                                            icon: Icon(
                                              Icons.done,
                                              color: Colors.green,
                                              size: 37,
                                            ),
                                            onPressed: () {},
                                          );
                                        } else {
                                          b = IconButton(
                                            icon: Icon(
                                              Icons.clear,
                                              color: Colors.red,
                                              size: 37,
                                            ),
                                            onPressed: () {},
                                          );
                                        }
                                        return b;
                                      }())
                                      //onPressed Lägger till i vänner och tar bort från lista
                                      ));
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                    SizedBox(height: 45),
                    Text(
                      "Pending Requests",
                      style: style.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    sentRequest != null
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: sentRequest?.length ??
                                0, //lägga till vår egen lista på denna bör funka
                            itemBuilder: (BuildContext context, int index) {
                              SentRequest c = sentRequest?.elementAt(index);
                              return Card(
                                  elevation: 8.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: ListTile(
                                    leading: CircleAvatar(child: Text("PH")),
                                    title: Text(c.receiver.name ?? ""),
                                    subtitle:
                                        Text(c.receiver.phoneNumber ?? ""),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.hourglass_empty,
                                        color: Colors.yellow,
                                        size: 37,
                                      ),
                                      onPressed: () {
                                        cancleRequestAlert(
                                            context, c.receiver.phoneNumber);
                                      },
                                    ),
                                  ));
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ],
                )
              ])),
          SearchUsers()
        ],
        controller: _tabController,
      ),
    );
  }

  _getFriendPos() {}
}

class SearchUsers extends StatefulWidget {
  SearchUsers({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<SearchUsers> {
  TextEditingController editingController = TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  bool userExists = true;

  var items = List<User>();

  Future<void> getInfo() async {
    //sentRequests

    var url =
        'https://group6-15.pvt.dsv.su.se/contacts/sentRequests?uid=${userlib.uid}';
    var response = await http.get(Uri.parse(url));
    setState(() {
      sentRequest = (json.decode(response.body) as List)
          .map((i) => SentRequest.fromJson(i))
          .toList();
      print(response.statusCode);
    });

    url =
        'https://group6-15.pvt.dsv.su.se/contacts/waitingRequests?uid=${userlib.uid}';
    response = await http.get(Uri.parse(url));
    setState(() {
      waitingRequest = (json.decode(response.body) as List)
          .map((i) => SentRequest.fromJson(i))
          .toList();
      print(response.statusCode);
    });

    url = 'https://group6-15.pvt.dsv.su.se/contacts/all?uid=${userlib.uid}';
    response = await http.get(Uri.parse(url));
    if (response.body != "") {
      final body = json.decode(response.body);

      print("LOAD FRIENDS");
      setState(() {
        friends = (json.decode(jsonEncode(body["user"])) as List)
            .map((i) => User.fromJson(i))
            .toList();
        print(response.statusCode);
      });
    } else {
      print("NO FRIENDS");
      friends.clear();
    }
  }

  showAlertDialogApproved(BuildContext context) {
    // set up the buttons
    getInfo();
    Widget okButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
        child: Text("Ok",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text("Friend request sent"),
      content: Text(
          "When this user accept your request they will show up in your friendlist"),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogFriendsAlready(BuildContext context) {
    getInfo();
    // set up the buttons
    Widget okButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
        child: Text("Ok",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text("You are already friends"),
      content: Text("You are already friends with this user"),
      actions: [okButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  showAlertDialogYourSelf(BuildContext context) {
    getInfo();
    // set up the buttons
    Widget okButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
        child: Text("Ok",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text("You cannot add yourself"),
      content: Text("..."),
      actions: [okButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  showAlertDialogDeclined(BuildContext context) {
    getInfo();
    // set up the buttons
    Widget okButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
        child: Text("Ok",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text("No User Found"),
      content: Text(
          "Please make sure that phonenumber is correct and that the user is registered"),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String phone;
    return new Scaffold(
      backgroundColor: colorBeige,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Add by number",
                            labelStyle: style.copyWith(fontSize: 18),
                            hintText: "ex:0701112233",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a phone number.' : null,
                        onChanged: (val) {
                          phone = val;
                          //setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          color: colorPrimaryRed,
                          elevation: 6.0,
                          child: Text(
                            'Add user',
                            style: style.copyWith(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            if (phone != null) {
                              var url =
                                  'https://group6-15.pvt.dsv.su.se/contacts/new';

                              var response = await http.post(Uri.parse(url),
                                  body: {
                                    'sendUid': userlib.uid,
                                    'phone': phone
                                  });
                              print(response.body);
                              if (response.statusCode == 200) {
                                if (response.body == "Sent friend request") {
                                  showAlertDialogApproved(context);
                                } else if (response.body == "Already friends") {
                                  showAlertDialogFriendsAlready(context);
                                } else if (response.body ==
                                    "You can not add your self") {
                                  showAlertDialogYourSelf(context);
                                } else {
                                  showAlertDialogDeclined(context);
                                }
                              }
                            }
                          })
                    ])))
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatefulWidget {
  final User user;

  ProfileInfo(this.user);

  @override
  ProfileInfoState createState() => new ProfileInfoState();
}

class ProfileInfoState extends State<ProfileInfo> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String kmString = "0";
  String routeTimeString = "0";
  List<latlng.LatLng> points = <latlng.LatLng>[];

  Future<void> openSavedRoutes(String id) async {
    final data = await http
        .get("https://group6-15.pvt.dsv.su.se/route/getRoute?id=${id}");
    print(data.body);
    if (data.statusCode == 200) {
      points.clear();
      List<latlng.LatLng> points1 = <latlng.LatLng>[];

      var jsonfile = json.decode(data.body);

      var routedata = jsonfile['routes'][0];
      var route = routedata["geometry"]["coordinates"];

      var estimatedTime =
          (routedata["duration"] / 3600).toStringAsFixed(2).toString();
      // MAN KAN ÄNDRA GÅNGHASTIGHET FÖR ATT FÅ MER ACCURATE

      for (var i = 0; i < route.length; i++) {
        points1.add(new latlng.LatLng(route[i][1], route[i][0]));
      }
      setState(() {
        kmString = (routedata["distance"] / 1000).toStringAsFixed(2);
        routeTimeString = estimatedTime;
        points = points1;
      });
    } else {
      // ERROR HÄR
    }
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: colorBeige,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text("Remove as friend?",
          style: style.copyWith(fontWeight: FontWeight.bold)),
      content: Text(
          "Are you sure you want to remove user from your friendslist?",
          style: style.copyWith(fontSize: 17)),
      actions: [
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.red,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("No"),
        ),
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.green,
          onPressed: () async {
            Navigator.of(context).pop(); // dismiss dialog
            var url = 'https://group6-15.pvt.dsv.su.se/contacts/remove';

            var response = await http.post(Uri.parse(url),
                body: {'uid': userlib.uid, 'phone': widget.user.phoneNumber});
            print(response.statusCode);
            getInfo();
          },
          child: Text("Yes"),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> getInfo() async {
    //sentRequests

    var url =
        'https://group6-15.pvt.dsv.su.se/contacts/sentRequests?uid=${userlib.uid}';
    var response = await http.get(Uri.parse(url));
    setState(() {
      sentRequest = (json.decode(response.body) as List)
          .map((i) => SentRequest.fromJson(i))
          .toList();
      print(response.statusCode);
    });

    url =
        'https://group6-15.pvt.dsv.su.se/contacts/waitingRequests?uid=${userlib.uid}';
    response = await http.get(Uri.parse(url));
    setState(() {
      waitingRequest = (json.decode(response.body) as List)
          .map((i) => SentRequest.fromJson(i))
          .toList();
      print(response.statusCode);
    });

    url = 'https://group6-15.pvt.dsv.su.se/contacts/all?uid=${userlib.uid}';
    response = await http.get(Uri.parse(url));
    if (response.body != "") {
      final body = json.decode(response.body);

      print("LOAD FRIENDS");
      setState(() {
        friends = (json.decode(jsonEncode(body["user"])) as List)
            .map((i) => User.fromJson(i))
            .toList();
        print(response.statusCode);
      });
    } else {
      print("NO FRIENDS");
      friends.clear();
    }
  }

  getFriendPos(User c) async {
    if (c.position.x != null) {
      final coordinates = new Coordinates(c.position.y, c.position.x);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      return addresses.first.addressLine;
    }
    return "unavailable";
  }

  Future<Image> getPicture(Dog d) async {
    Image temp;
    await d.getPicture();
    setState(() {
      temp = d.dogPic;
    });
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBeige,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: //Row med items
              MaterialButton(
            shape: CircleBorder(),
            elevation: 0,
            child: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Hero(
                  tag: "BrewDog.jpg",
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20.0),
                    child: Image(
                      height: 400.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: AssetImage("BrewDog.jpg"),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  widget.user.name,
                  style: style.copyWith(
                      fontSize: 25.0,
                      color: colorDarkRed,
                      fontWeight: FontWeight.bold),
                ),
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                color: colorPeachPink,
                shape: BeveledRectangleBorder(),
                elevation: 15,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person_pin),
                    Text("View on map")
                  ],
                ),
                onPressed: () {
                  latlng.LatLng coordinates = latlng.LatLng(
                      widget.user.position.y, widget.user.position.x);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MapsDemo(coordinates)));
                },
              ),
              RaisedButton(
                color: colorPeachPink,
                shape: BeveledRectangleBorder(),
                elevation: 15,
                child: Row(children: <Widget>[
                  Icon(Icons.remove_circle),
                  Text("Remove Friend"),
                ]),
                onPressed: () {
                  showAlertDialog(context);
                },
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "My Dogs",
                    style: style.copyWith(
                        color: colorDarkRed, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Container(
                      height: 70,
                      child: widget.user.ownedDog != null
                          ? ListView.builder(
                              //https://pusher.com/tutorials/flutter-listviews

                              shrinkWrap: true,
                              itemCount: widget.user.ownedDog?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                Dog c = widget.user.ownedDog?.elementAt(index);
                                return (c.name != null && c.name.length > 0)
                                    ? SizedBox(
                                        child: InkWell(
                                            onTap: () async {
                                              await c.getPicture();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DogProfile(c)),
                                              );
                                            },
                                            child: Stack(children: <Widget>[
                                              Positioned.fill(
                                                  child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  c.name,
                                                  style: style.copyWith(
                                                      fontSize: 9.0,
                                                      color: Colors.black,
                                                      backgroundColor:
                                                          Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                              Container(
                                                width: 75,
                                                height: 75,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  child: c.dogPic == null
                                                      ? Image.asset(
                                                          "logoprototype.png")
                                                      : FittedBox(
                                                          child: c.dogPic,
                                                          fit: BoxFit.cover,
                                                        ),
                                                  //   child: FutureBuilder<dynamic>(
                                                  //   future: getPicture(c),
                                                  //   builder: (BuildContext context,
                                                  //       AsyncSnapshot<dynamic>
                                                  //           snapshot) {
                                                  //     if (snapshot.hasData) {
                                                  //       return FittedBox(
                                                  //         child: snapshot.data,
                                                  //         fit: BoxFit.cover,
                                                  //       );
                                                  //     } else {
                                                  //       return Image.asset(
                                                  //           "logoprototype.png");
                                                  //     }
                                                  //   },
                                                  // ),
                                                ),
                                              ),
                                            ])))
                                    : SizedBox(
                                        child: InkWell(
                                            onTap: () async {
                                              await c.getPicture();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DogProfile(c)),
                                              );
                                            },
                                            child: Stack(children: <Widget>[
                                              Positioned.fill(
                                                  child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  c.name,
                                                  style: style.copyWith(
                                                      fontSize: 9.0,
                                                      color: Colors.black,
                                                      backgroundColor:
                                                          Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                              Container(
                                                width: 75,
                                                height: 75,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  child: Image.asset(
                                                    'logoprototype.png',
                                                  ),
                                                ),
                                              ),
                                            ])));
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    )),
                Container(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "My Saved Routes",
                    style: style.copyWith(
                        color: colorDarkRed, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Container(
                      height: 70,
                      child: widget.user.savedRoutes != null
                          ? ListView.builder(
                              //https://pusher.com/tutorials/flutter-listviews

                              shrinkWrap: true,
                              itemCount: widget.user.savedRoutes?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                SavedRoutes c =
                                    widget.user.savedRoutes?.elementAt(index);
                                return (c.name != null && c.name.length > 0)
                                    ? SizedBox(
                                        child: InkWell(
                                          onTap: () async {
                                            await openSavedRoutes(
                                                c.id.toString());
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MapPreviewPage(
                                                        kmString: kmString,
                                                        points: points,
                                                        openedThroughprofile:
                                                            true,
                                                      )),
                                            );
                                          },
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                width: 75,
                                                height: 75,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child: Icon(
                                                      Icons.directions_walk,
                                                      size: 30,
                                                    )),
                                              ),
                                              Positioned.fill(
                                                  child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  c.name,
                                                  style: style.copyWith(
                                                      fontSize: 9.0,
                                                      color: colorDarkRed,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        child: InkWell(
                                        onTap: () async {
                                          await openSavedRoutes(
                                              c.id.toString());
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MapPreviewPage(
                                                      kmString: kmString,
                                                      points: points,
                                                      openedThroughprofile:
                                                          true,
                                                    )),
                                          );
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              width: 75,
                                              height: 75,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  child: Icon(
                                                    Icons.directions_walk,
                                                    size: 30,
                                                  )),
                                            ),
                                            Positioned.fill(
                                                child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                c.name,
                                                style: style.copyWith(
                                                    fontSize: 9.0,
                                                    color: colorDarkRed,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                          ],
                                        ),
                                      ));
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    )),
                Container(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "User Information", //userData
                    style: style.copyWith(
                      color: colorDarkRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ...ListTile.divideTiles(
                              color: Colors.grey,
                              tiles: [
                                ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  leading: Icon(
                                    Icons.my_location,
                                    color: colorDarkRed,
                                  ),
                                  title: Text(
                                    "Location",
                                    style: style.copyWith(
                                        color: colorDarkRed,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: FutureBuilder<dynamic>(
                                    future: getFriendPos(widget.user),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data,
                                          style: style.copyWith(
                                              color: Colors.grey.shade700,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else {
                                        return Text("Loading",
                                            style: TextStyle(
                                              color: colorDarkRed,
                                            ));
                                      }
                                    },
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.email,
                                    color: colorDarkRed,
                                  ),
                                  title: Text(
                                    "Email",
                                    style: style.copyWith(
                                        color: colorDarkRed,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    widget.user.email,
                                    style: style.copyWith(
                                        color: Colors.grey.shade700,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.phone,
                                    color: colorDarkRed,
                                  ),
                                  title: Text(
                                    "Phone",
                                    style: style.copyWith(
                                        color: colorDarkRed,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    widget.user.phoneNumber,
                                    style: style.copyWith(
                                        color: Colors.grey.shade700,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ])));
  }
}

class CircularClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - size.width / 4,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  ClipShadowPath({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
