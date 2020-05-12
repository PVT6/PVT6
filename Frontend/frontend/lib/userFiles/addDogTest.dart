import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend/userFiles/addDogClasses/transition.dart';
import 'package:frontend/userFiles/addDogClasses/submitSlider.dart';
import 'package:frontend/userFiles/addDogClasses/weightSlider.dart';
import 'package:frontend/userFiles/addDogClasses/genderSlider.dart';
import 'package:frontend/userFiles/addDogClasses/heightSlider.dart';
import 'package:frontend/userFiles/addDogClasses/ageSlider.dart';
import 'package:frontend/userFiles/addDogClasses/dogPicture.dart';
import 'package:frontend/userFiles/addDogClasses/searchBreed.dart';

const colorPurple = const Color(0xFF82658f);
const colorPeachPink = const Color(0xFFffdcd2);
const colorLighterPink = const Color(0xFFffe9e5);
String dogName;
String finalBreed;
int height = 40;
int weight = 15;
int age = 0;
Gender gender = Gender.female;

const Color mainBlue = const Color.fromRGBO(77, 123, 243, 1.0);
const double baseHeight = 850.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

const TextStyle _titleStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(14, 24, 35, 1.0),
);

const TextStyle _subtitleStyle = TextStyle(
  fontSize: 8.0,
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(78, 102, 114, 1.0),
);

class CardTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const CardTitle(this.title, {Key key, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: _titleStyle,
        children: <TextSpan>[
          TextSpan(
            text: subtitle ?? "",
            style: _subtitleStyle,
          ),
        ],
      ),
    );
  }
}

class Breed {
  final String breed;
  Breed(this.breed);
}

class NameSelect extends StatefulWidget {
  NameSelect({Key key, this.title}) : super(key: key);
  final String title;

  @override
  NameSelectState createState() => new NameSelectState();
}

class NameSelectState extends State<NameSelect> {
  TextEditingController editingController = TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  bool _isVisible = true;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: Icon(Icons.verified_user),
          elevation: 0,
          title: Text('Name'),
          backgroundColor: colorPurple,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: showToast,
            )
          ],
        ),
        body: Visibility(
            visible: _isVisible,
            child: Column(children: <Widget>[
              TextFormField(
                obscureText: false,
                style: style,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Dogs Name",
                  icon: new Icon(
                    FontAwesomeIcons.dog,
                    color: Colors.blue,
                  ),
                ),
                validator: (value) =>
                    value.isEmpty ? 'Name can\'t be empty' : null,
                onChanged: (val) {
                  setState(() => dogName = val);
                },
              )
            ])));
  }
}

class InputPage extends StatefulWidget {
  @override
  InputPageState createState() {
    return new InputPageState();
  }
}

class InputPageState extends State<InputPage> with TickerProviderStateMixin {
  AnimationController _submitAnimationController;

  @override
  void initState() {
    super.initState();
    _submitAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _submitAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _goToResultPage().then((_) => _submitAnimationController.reset());
      }
    });
  }

  _goToResultPage() async {
    return Navigator.of(context).push(FadeRoute(
      builder: (context) => ResultPage(
        weight: weight,
        height: height,
        gender: gender,
        dogName: dogName,
        age: age,
        finalBreed: finalBreed,
      ),
    ));
  }

  @override
  void dispose() {
    _submitAnimationController.dispose();
    super.dispose();
  }

  void onDogSubmit() {
    _submitAnimationController.forward();
  }

  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
        appBar: new AppBar(
          title: new Text("Add Dog"),
          backgroundColor: colorPurple,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                  margin: EdgeInsets.all(10),
                  elevation: 20,
                  child:
                      Container(width: 420, height: 120, child: NameSelect())),
              Card(
                  margin: EdgeInsets.all(10),
                  elevation: 20,
                  child:
                      Container(width: 420, height: 520, child: BuildCards())),
              // _buildBottom(context),
              Card(
                  margin: EdgeInsets.all(10),
                  elevation: 20,
                  child: Container(
                      width: 420, height: 500, child: SearchBreeds())),
              Card(
                  margin: EdgeInsets.all(10),
                  elevation: 20,
                  child:
                      Container(width: 420, height: 400, child: DogPictures())),
              SizedBox(
                height: 20,
              ),
              _buildBottom(context),
            ],
          ),
        ),
      ),
      TransitionDot(animation: _submitAnimationController),
    ]);
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: 24.0,
          top: screenAwareSize(56.0, context),
        ),
        child: Row(
          children: <Widget>[
            Text(
              "Add Dog",
              style: new TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  Widget _tempCard(String label) {
    return Card(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Text(label),
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenAwareSize(16.0, context),
        right: screenAwareSize(16.0, context),
        bottom: screenAwareSize(22.0, context),
        top: screenAwareSize(14.0, context),
      ),
      child: PacmanSlider(
        submitAnimationController: _submitAnimationController,
        onSubmit: onDogSubmit,
      ),
    );
  }
}

class BuildCards extends StatefulWidget {
  const BuildCards({Key key}) : super(key: key);

  @override
  BuildCardState createState() => BuildCardState();
}

class BuildCardState extends State<BuildCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.verified_user),
          elevation: 0,
          title: Text('Measurements'),
          backgroundColor: colorPurple,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: screenAwareSize(32.0, context),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                child: GenderCard(
                              gender: gender,
                              onChanged: (val) => setState(() => gender = val),
                            )),
                            Expanded(
                                child: AgeCard(
                              age: age,
                              onChanged: (val) => setState(() => age = val),
                            )),
                            Expanded(
                              child: WeightCard(
                                weight: weight,
                                onChanged: (val) =>
                                    setState(() => weight = val),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: HeightCard(
                        height: height,
                        onChanged: (val) => setState(() => height = val),
                      ))
                    ],
                  ),
                )
              ],
            )));
  }
}

class ResultPage extends StatefulWidget {
  final weight;
  final height;
  final gender;
  final dogName;
  final age;
  final finalBreed;

  const ResultPage(
      {Key key,
      this.weight,
      this.height,
      this.gender,
      this.dogName,
      this.age,
      this.finalBreed})
      : super(key: key);

  @override
  ResultPageState createState() => ResultPageState();
}

class ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final Color color1 = Color(0xffFC5CF0);
    final Color color2 = Color(0xffFE8852);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [color1, color2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Text(
                  "New Dog Added!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.asset(
                              "BrewDog.jpg",
                              fit: BoxFit.cover,
                            )),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text(widget.finalBreed),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.dogName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      " - ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      widget.age.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Weight: ",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Text(
                      widget.weight.toString(),
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Text(
                      " Height: ",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Text(
                      widget.height.toString(),
                      style: TextStyle(color: Colors.grey.shade600),
                    )
                  ],
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      color: Colors.grey,
                      icon: Icon(FontAwesomeIcons.instagram),
                      onPressed: () {},
                    ),
                    IconButton(
                      color: Colors.grey,
                      icon: Icon(FontAwesomeIcons.facebookF),
                      onPressed: () {},
                    ),
                    IconButton(
                      color: Colors.grey.shade600,
                      icon: Icon(FontAwesomeIcons.twitter),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 16.0),
                        margin: const EdgeInsets.only(
                            top: 30, left: 20.0, right: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color1, color2],
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              color: Colors.white,
                              icon: Icon(FontAwesomeIcons.user),
                              onPressed: () {},
                            ),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.location_on),
                              onPressed: () {},
                            ),
                            Spacer(),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.add),
                              onPressed: () {},
                            ),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.message),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: FloatingActionButton(
                          child: Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
