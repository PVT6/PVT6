import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:frontend/dogPlaceDesc.dart';


var green = Color(0xFF4caf6a);
var greenLight = Color(0xFFd8ebde);

var red = Color(0xFFf36169);
var redLight = Color(0xFFf2dcdf);

var blue = Color(0xFF398bcf);
var blueLight = Color(0xFFc1dbee);
LatLng location = new LatLng(0, 0);

class DogsNearMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Container(
          child: ListView(
            children: <Widget>[
              MyAppBar(),
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              MenuItemsList()
            ],
          ),
        ));
  }
}

class MenuItemsList extends StatelessWidget {
  const MenuItemsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) { //denna borde vara en listview med object utifrån skapade profiler
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Dogs Near Me',
            style: TextStyle(fontSize: 22.0, color: Colors.black54),
          ),
          SizedBox(height: 16.0),
          MenuItem(
            "BrewDog.jpg",
            'Hundöarna Drottningholm',
            'Looking for a place where your dog can run free with other dogs look no further, ...',
            () => {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DogPlaceDesc2(
                            "Hundoarna.jpg",
                            '4.5',
                            'Location',
                            'Hundöarna Drottningholm',
                            "Looking for a place where your dog can run free with other dogs look no further, hundöarna at Drottningholms castle are is by all means the place for you to visit. The park is home for majestice trees and bridges, aswell as a quite place for peaceful walks. Perfect for walkers and dogowners alike.",
                            () => {},
                            () => {},
                            location = new LatLng(59.321841, 17.886783),
                          )))
            },
          ),
          SizedBox(
            height: 10,
          ),
          MenuItem(
            "ormingesHundrastgard.jpg",
            'Orminges hundrastgård',
            'With an agility track aswell aswell as an abundance of trees, ...',
            () => {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DogPlaceDesc2(
                            "ormingesHundrastgard.jpg",
                            '4.5',
                            'Location',
                            'Orminges hundrastgård',
                            'With an agility track aswell as an abundance of trees, + desc',
                            () => {},
                            () => {},
                            location = new LatLng(59.334389, 18.254072),
                          )))
            },
          ),
          SizedBox(
            height: 10,
          ),
          MenuItem(
            "AkersbergasHundpark.jpg",
            'Åkersbergas hundpark',
            'Exercise for both you and your dog, ...',
            () => {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DogPlaceDesc2(
                            "AkersbergasHundpark.jpg",
                            '4.5',
                            'Location',
                            'Åkersbergas hundpark',
                            'Exercise for both you and your dog, + desc',
                            () => {},
                            () => {},
                            location = new LatLng(59.491098, 18.281011),
                          )))
            },
          ),
          SizedBox(
            height: 10,
          ),
          MenuItem(
            "hundrastgard-henriksdal.jpg",
            'Henriksdalsbergets hundrastgård',
            'Varied walking in dynamic enviroments, ...',
            () => {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DogPlaceDesc2(
                            "hundrastgard-henriksdal.jpg",
                            '4.5',
                            'Location',
                            'Henriksdalsbergets hundrastgård',
                            'Varied walking in dynamic enviroments, + desc',
                            () => {},
                            () => {},
                            location = new LatLng(59.311540, 18.118437),
                          )))
            },
          ),
          SizedBox(
            height: 10,
          ),
          MenuItem(
            "Valdemarsudde.jpg",
            'Waldermarsuddes hundrastområde',
            'Big closed in dog park with stunning enviroment, ...',
            () => {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DogPlaceDesc2(
                            "Valdemarsudde.jpg",
                            '4.5',
                            'Location',
                            'Waldersmarsuddes hundrastområde',
                            'Big closed in dog park with stunning enviroment, + desc',
                            () => {},
                            () => {},
                            location = new LatLng(59.320092, 18.113662),
                          )))
            },
          ),
          SizedBox(
            height: 10,
          ),
          MenuItem(
            "BrommaKyrka.jpg",
            'Bromma kyrka hundrastområde',
            'In this beautiful forest your dogs can run free through hills and paths, ...',
            () => {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DogPlaceDesc2(
                            "BrommaKyrka.jpg",
                            '4.5',
                            'Location',
                            'Bromma kyrka hundrastområde',
                            'In this beautiful forest your dogs can run free through hills and paths, + desc',
                            () => {},
                            () => {},
                            location = new LatLng(59.355280, 17.920966),
                          )))
            },
          ),
          SizedBox(
            height: 10,
          ),
          MenuItem(
            "Langholmen.jpg",
            'Långholmens hundrastgård',
            'Dog friendly enviroments with a local cafee where dogs are most welcome, ...',
            () => {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DogPlaceDesc2(
                            "Langholmen.jpg",
                            '4.5',
                            'Location',
                            'Långholmens hundrastgård',
                            'Dog friendly enviroments with a local cafee where dogs are most welcome, + desc',
                            () => {},
                            () => {},
                            location = new LatLng(59.321889, 18.034564),
                          )))
            },
          ),
          SizedBox(
            height: 10,
          ),
          MenuItem(
            "Bellevueparken.jpg",
            'Bellevueparkens hundrastområde',
            'Soothing dog walks in a 30.000 square meter territory, ...',
            () => {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DogPlaceDesc2(
                            "Bellevueparken.jpg",
                            '4.5',
                            'Location',
                            'Bellevueparkens hundrastområde',
                            'Soothing dog walks in a 30.000 square meter territory, + desc',
                            () => {},
                            () => {},
                            location = new LatLng(59.354116, 18.047865),
                          )))
            },
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MaterialButton(
            color: Colors.white,
            shape: CircleBorder(),
            elevation: 0,
            child: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Stockholm',
                style: TextStyle(color: Colors.black54),
              ),
              Text(
                'Dogs Near Me',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String image;

  final String title;
  final String desc;
  final Function onTap;

  MenuItem(this.image, this.title, this.desc, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 100.0,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Container(
                            width: 200.0,
                            child: Text(
                              desc,
                              style: TextStyle(color: Colors.grey),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
