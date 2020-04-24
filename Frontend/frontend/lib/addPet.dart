import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddDog extends StatefulWidget {
  AddDog() : super();

  final String title = "Maps Demo";

  @override
  AddDogState createState() => AddDogState();
}

class AddDogState extends State<AddDog> {
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  List _sex = [
    "Male",
    "Female",
  ];

  List<DropdownMenuItem<String>> _dropDownMenuItemsSex;
  String _currentSex;

    List _cities =
  ["Yes", "No"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  @override
  void initState() {
    _dropDownMenuItemsSex = getDropDownMenuItemsSex();
    _currentSex = _dropDownMenuItemsSex[0].value;
      _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
  }
    List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsSex() {
    List<DropdownMenuItem<String>> items = new List();
    for (String sex in _sex) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: sex, child: new Text(sex)));
    }
    return items;
  }
  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }


  void changedDropDownItemSex(String selectedSex) {
    print("Selected city $selectedSex, we are going to refresh the UI");
    setState(() {
      _currentSex = selectedSex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ProfileHeader(
            avatar: new AssetImage("profilePH.png"),
            coverImage: new AssetImage("backgroundStockholm.png"),
            actions: <Widget>[
              //Row med items

              SizedBox(
                width: 230,
              ),
              MaterialButton(
                color: Colors.white,
                shape: CircleBorder(),
                elevation: 0,
                child: Icon(Icons.photo),
                onPressed: () {
                },
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.wrap_text),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 250,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Name", hasFloatingPlaceholder: true),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.pets),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 250,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Type", hasFloatingPlaceholder: true),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.pets),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 250,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Breed", hasFloatingPlaceholder: true),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.person),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Gender"),
                  SizedBox(
                    width: 14,
                  ),
                  DropdownButton(
                    value: _currentSex,
                    items: _dropDownMenuItemsSex,
                    onChanged: changedDropDownItemSex,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.toys),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Neutered"),
                  SizedBox(width: 27,),
                DropdownButton(
                value: _currentCity,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              )
                  
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Icon(FontAwesomeIcons.weight),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 250,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Weight", hasFloatingPlaceholder: true),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Icon(FontAwesomeIcons.textHeight),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 250,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Height", hasFloatingPlaceholder: true),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.pin_drop),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 250,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Chip ID", hasFloatingPlaceholder: true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final List<Widget> actions;

  const ProfileHeader(
      {Key key, @required this.coverImage, @required this.avatar, this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 140),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 60,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 120),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.camera),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key key,
      @required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
        ),
      ),
    );
  }
}
