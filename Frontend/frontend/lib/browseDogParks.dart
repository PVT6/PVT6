import 'package:flutter/material.dart';
import 'package:frontend/loginFiles/intro_slider.dart';
import 'package:frontend/userFiles/dogProfile.dart';
import 'package:latlong/latlong.dart';
import 'package:frontend/dogPlaceDesc.dart';

var textYellow = Color(0xFFf6c24d);
var iconYellow = Color(0xFFf4bf47);

var green = Color(0xFF4caf6a);
var greenLight = Color(0xFFd8ebde);

var red = Color(0xFFf36169);
var redLight = Color(0xFFf2dcdf);

var blue = Color(0xFF398bcf);
var blueLight = Color(0xFFc1dbee);
LatLng location = new LatLng(0, 0);

class BrowseDogParks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 16.0),
              MyAppBar(),
              SizedBox(height: 16.0),
              FoodListview(),
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Highest rated dogparks',
            style: TextStyle(fontSize: 22.0, color: Colors.black54),
          ),
          SizedBox(height: 16.0),
          MenuItem(
            "Hundoarna.jpg",
            '4.5',
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
                            () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IntroScreen()),
                              )
                            },
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
            "4.5",
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
            '4.5',
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
            '4.5',
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
            '4.5',
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
            '4.5',
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
            '4.5',
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
            '4.5',
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

class FoodListview extends StatelessWidget {
  const FoodListview({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        height: 160.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            ItemCard(
              "HimmelskaHundar.jpg",
              'Himmelska Hundar',
              'For dogs and owners',
              () => {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => DogPlaceDesc2(
                              "HimmelskaHundar.jpg",
                              '4.5',
                              'Location',
                              'Himmelska Hundar',
                              'For dogs and owners, + desc',
                              () => {},
                              () => {},
                              location = new LatLng(59.343431, 18.094141),
                            )))
              },
            ),
            ItemCard(
              "LeBistro.jpg",
              'Le Bistro',
              'Dog friendly enviroment',
              () => {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => DogPlaceDesc2(
                              "LeBistro.jpg",
                              '4.5',
                              'Location',
                              'Le Bistro',
                              'Dog friendly enviroment, + desc',
                              () => {},
                              () => {},
                              location = new LatLng(59.334809, 18.032341),
                            )))
              },
            ),
            ItemCard(
              "BrewDog.jpg",
              'Brewdog',
              'Offers dog "Beer"',
              () => {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => DogPlaceDesc2(
                              "BrewDog.jpg",
                              '4.5',
                              'Location',
                              'Brewdog',
                              'Offers dog "Beer", + desc',
                              () => {},
                              () => {},
                              location = new LatLng(59.336378, 18.034161),
                            )))
              },
            ),
            ItemCard(
              "DogBakery.jpg",
              'Dog bakery',
              'Homemade dog pasteries',
              () => {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => DogPlaceDesc2(
                              "DogBakery.jpg",
                              '4.5',
                              'Location',
                              'Dog bakery',
                              'Homemade dog pasteries, + desc',
                              () => {},
                              () => {},
                              location = new LatLng(59.340565, 18.040249),
                            )))
              },
            ),
          ],
        ),
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
                'Dog friendly locations',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  final Function onTap;

  ItemCard(this.image, this.title, this.desc, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
              height: 160.0,
              width: 300.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover)),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 160.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Spacer(),
                        Text(
                          title,
                          style: TextStyle(
                              color: textYellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              letterSpacing: 1.1),
                        ),
                        Text(
                          desc,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              letterSpacing: 1.1),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}

class MenuItem extends StatelessWidget {
  final String image;
  final String rating;
  final String title;
  final String desc;
  final Function onTap;

  MenuItem(this.image, this.rating, this.title, this.desc, this.onTap);

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
                        Container(
                          decoration: BoxDecoration(
                              color: iconYellow,
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 15.0,
                                ),
                                Text(rating)
                              ],
                            ),
                          ),
                        ),
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
