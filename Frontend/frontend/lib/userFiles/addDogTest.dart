import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:frontend/friendsAndContacts/friendsPage.dart';
import 'package:frontend/userFiles/addDogClasses/transition.dart';
import 'package:frontend/userFiles/addDogClasses/submitSlider.dart';
import 'package:frontend/userFiles/addDogClasses/weightSlider.dart';
import 'package:frontend/userFiles/addDogClasses/genderSlider.dart';
import 'package:frontend/userFiles/addDogClasses/heightSlider.dart';
import 'package:frontend/userFiles/addDogClasses/ageSlider.dart';
import 'package:frontend/userFiles/addDogClasses/dogPicture.dart';
import 'package:frontend/userFiles/addDogClasses/searchBreed.dart';
import 'package:frontend/userFiles/profile.dart';
import 'package:http/http.dart' as http;
import '../customAppBar.dart';
import 'user.dart' as userlib;
import '../dog.dart';

String dogName;
String finalBreed;
int height = 40;
int weight = 15;
int age = 0;
String dogPicture;
String desc = "";
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: colorLighterPink,
        body: Column(
          children: <Widget>[
            GradientAppBar("Name"),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
              ],
              obscureText: false,
              style: style,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Name here',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              validator: (value) =>
                  value.isEmpty ? 'Name can\'t be empty' : null,
              onChanged: (val) {
                setState(() => dogName = val);
              },
            )
          ],
        ));
  }
}

class DescSelect extends StatefulWidget {
  DescSelect({Key key, this.title}) : super(key: key);
  final String title;

  @override
  DescSelectState createState() => new DescSelectState();
}

class DescSelectState extends State<DescSelect> {
  TextEditingController editingController = TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: colorLighterPink,
        body: Column(children: <Widget>[
          GradientAppBar(
            "Description",
          ),
          TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(125),
            ],
            autocorrect: true,
            obscureText: false,
            minLines: 4,
            maxLines: 5,
            style: style,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Write a short description of your dog here',
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
            onChanged: (val) {
              setState(() => desc = val);
            },
          ),
        ]));
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
    //reset variabler start
    String dogName1;
    String finalBreed1;
    int height1 = 40;
    int weight1 = 15;
    int age1 = 0;
    String dogPicture1;
    String desc1 = "";
    Gender gender1 = Gender.female;
    dogName = dogName1;
    finalBreed = finalBreed1;
    height = height1;
    weight = weight1;
    age = age1;
    dogPicture = dogPicture1;
    desc = desc1;
    gender = gender1;
    //end
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

  showAlertDialog(BuildContext context) {
    Widget loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: colorPurple,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
        child: Text("Ok",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Text(
        "Error",
        style: TextStyle(color: Colors.red),
      ),
      content: Text("Please make sure you added a name and a breed"),
      actions: [
        loginButon,
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

  _goToResultPage() async {
    if (dogName == null || finalBreed == null) {
      return showAlertDialog(context);
    } else {
      var url = 'https://group6-15.pvt.dsv.su.se/user/newdog';
      var response = await http.post(Uri.parse(url), body: {
        'name': dogName,
        'breed': finalBreed,
        'age': age.toString(),
        'weight': weight.toString(),
        'uid': userlib.uid
      });
      if (response.statusCode == 200) {
        return Navigator.of(context).push(FadeRoute(
          builder: (context) => ResultPage(
            weight: weight,
            height: height,
            gender: gender,
            dogName: dogName,
            age: age,
            finalBreed: finalBreed,
            dogPicture: dogPicture,
            desc: desc,
          ),
        ));
      } else {
        // ERROR MEDELANDE HÄR
      }
    }
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
              _buildTitle(context),
              Card(
                  margin: EdgeInsets.all(10),
                  elevation: 20,
                  child:
                      Container(width: 420, height: 120, child: NameSelect())),
              Card(
                  margin: EdgeInsets.all(10),
                  elevation: 20,
                  child:
                      Container(width: 420, height: 186, child: DescSelect())),
              Card(
                  margin: EdgeInsets.all(10),
                  elevation: 20,
                  child:
                      Container(width: 420, height: 520, child: BuildCards())),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Slide to Save",
                    style: TextStyle(
                      fontFamily: 'Hipster Script W00 Regular',
                      fontSize: 32,
                    ),
                  ),
                ],
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
            Container(
              width: 80,
              height: 80,
              child: Image.asset("logopurplepink.png"),
            ),
            Text(
              "Please fill in the form",
              style: new TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
          ],
        ));
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
        backgroundColor: colorLighterPink,
        body: Column(children: <Widget>[
          GradientAppBar(
            "Description",
          ),
          Expanded(
              child: Container(
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
                                    onChanged: (val) =>
                                        setState(() => gender = val),
                                  )),
                                  Expanded(
                                      child: AgeCard(
                                    age: age,
                                    onChanged: (val) =>
                                        setState(() => age = val),
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
                  )))
        ]));
  }
}

class ResultPage extends StatefulWidget {
  final weight;
  final height;
  final gender;
  final dogName;
  final age;
  final finalBreed;
  final dogPicture;
  final desc;

  const ResultPage(
      {Key key,
      this.desc,
      this.dogPicture,
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context)
        ),
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
      extendBodyBehindAppBar: true,
      backgroundColor: colorLighterPink,
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [colorPeachPink, colorPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Text(
                  "Dog Added!",
                  style: TextStyle(
                    fontFamily: 'Hipster Script W00 Regular',
                    color: Colors.white,
                    fontSize: 36,
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        width: 380,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: dogPicture == null
                                ? Image.asset("logopurplepink.png")
                                : Image.file(
                                    File(
                                      dogPicture,
                                    ),
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
                          child: Text(widget.finalBreed,
                              style: TextStyle(
                                fontSize: 16,
                              )),
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
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 280,
                  height: 80,
                  child: Text(desc),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Weight: ",
                          style: TextStyle(
                            color: colorPurple,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.weight.toString() + "kg",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Height: ",
                          style: TextStyle(
                            color: colorPurple,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.height.toString() + "cm",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          " Age: ",
                          style: TextStyle(
                            color: colorPurple,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.age.toString() + "y.o",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                SizedBox(height: 10.0),
                Column(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileEightPage()),
                          );
                        },
                        child: Container(
                            width: 380,
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
                            margin: const EdgeInsets.only(
                                top: 1, left: 30.0, right: 30.0, bottom: 1),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [colorPeachPink, colorPurple],
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.center,
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
