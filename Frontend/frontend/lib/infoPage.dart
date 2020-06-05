import 'package:flutter/material.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:frontend/loginFiles/intro_slider.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 4,
            valueColor: AlwaysStoppedAnimation(colorDarkRed)),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 60.0),
        Container(
          height: 100,
          width: 100,
          child: Image.asset("logoprotonotext.png"),
        ),
        Container(
          width: 90.0,
          child: new Divider(color: colorDarkRed),
        ),
        SizedBox(height: 10.0),
        Text(
          "Introduction to DogWalk",
          style: TextStyle(color: Colors.white, fontSize: 40.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "A School project",
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.56,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("DogBackground.jpg"),
                fit: BoxFit.fill,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.56,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          //decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          decoration: BoxDecoration(color: Color.fromRGBO(105, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ],
    );

    final bottomContentText = Text(
      "DogWalk is the product of nine hard working students from Stockholm university getting together during a"
      " product developing course.\n\nThe application uses API:s such as locations of trashcans and streetlights, together with map functions and route generators."
      "All these functions are intended to help both you and your dog make more interesting and memorable walks together. Since we also know our furries friends like to find new playmates, we also implemented a fully functioning friendsystem.\n \nWe sincerely hope you will enjoy using it!",
      style: TextStyle(fontSize: 14.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IntroScreen()),
            ),
          },
          color: colorDarkRed,
          child:
              Text("Revisit Tutorial", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
