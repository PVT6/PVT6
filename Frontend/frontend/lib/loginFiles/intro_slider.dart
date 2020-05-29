import 'package:flutter/material.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:frontend/mapFiles/mapsDemo.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:latlong/latlong.dart' as latlng;

class IntroScreen extends StatefulWidget {
  IntroScreen() : super();

  final String title = "Maps Demo";

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();
  latlng.LatLng setter = latlng.LatLng(0,0);

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "MAP",
        description:
            "Search arround on the map! \n The map will also work as your home page.",
        styleTitle: style.copyWith(fontSize: 30.0),
        styleDescription: style.copyWith(fontSize: 30.0),
        pathImage: "assets/Kartatransparent.png",
        backgroundColor: colorPrimaryRed,
      ),
    );
    slides.add(
      new Slide(
        title: "ADD FRIENDS",
        description:
            "Add dog friends and join them for a walk. \n You can also see your friends on the map. \n\n Way more fun to take walks together!",
        styleTitle: style.copyWith(fontSize: 30.0, color: Colors.white),
        styleDescription: style.copyWith(fontSize: 30.0, color: Colors.white),
        pathImage: "assets/addfriendsslide.png",
        backgroundColor: colorDarkBeige,
      ),
    );
    slides.add(
      new Slide(
        title: "GENERATE ROUTE",
        description:
            "Get inspiration on new walking routes by clicking on the dice icon. \n Set a distance and let the app make you a route!",
        styleTitle: style.copyWith(fontSize: 30.0),
        styleDescription: style.copyWith(fontSize: 30.0),
        pathImage: "assets/diceslide.png",
        backgroundColor: colorPrimaryRed,
      ),
    );

    slides.add(
      new Slide(
        title: "DOG PROFILE",
        description: "Create your own profile for all of your dogs!",
        styleTitle: style.copyWith(fontSize: 30.0, color: Colors.white),
        styleDescription: style.copyWith(fontSize: 30.0, color: Colors.white),
        pathImage: "assets/dogslide.png",
        backgroundColor: colorDarkBeige,
      ),
    );
    slides.add(
      new Slide(
        title: "DOG FRIENDLY PLACES",
        description: "See dog friendly places on the map and bring your dog!",
        pathImage: "assets/mapplaces.png",
        styleTitle: style.copyWith(fontSize: 30.0),
        styleDescription: style.copyWith(fontSize: 30.0),
        backgroundColor: colorPrimaryRed,
      ),
    );
        slides.add(
      new Slide(
          title: "TRASH CAN",
          description:
              "In need of a trash can? \n\n Just zoom in where ever you are and you will see the nearest trash can on the map.",
          pathImage: "assets/trashcanslide.png",
          styleTitle: style.copyWith(fontSize: 30.0, color: Colors.white),
          styleDescription: style.copyWith(fontSize: 30.0, color: Colors.white),
          backgroundColor: colorDarkBeige),
    );
    slides.add(
      new Slide(
          title: "ENJOY",
          description:
              "Explore our app with your dog and make the time together even more enjoyable!",
          pathImage: "assets/logoprotonotext.png",
        styleTitle: style.copyWith(fontSize: 30.0),
        styleDescription: style.copyWith(fontSize: 30.0),
        backgroundColor: colorPrimaryRed,)
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapsDemo(setter)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
