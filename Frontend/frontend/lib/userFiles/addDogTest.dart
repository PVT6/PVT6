import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

const colorPurple = const Color(0xFF82658f);
const colorPeachPink = const Color(0xFFffdcd2);
const colorLighterPink = const Color(0xFFffe9e5);
String dogName;

enum Gender { male, female, other }

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
          backgroundColor: Theme.of(context).accentColor,
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

class SearchBreeds extends StatefulWidget {
  SearchBreeds({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SearchBreedState createState() => new SearchBreedState();
}

class SearchBreedState extends State<SearchBreeds> {
  TextEditingController editingController = TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  String filter;

  final duplicateItems = [
    Breed('Mixed Breed'),
    Breed('Afador'),
    Breed('Affenhuahua'),
    Breed('Affenpinscher'),
    Breed('Afghan Hound'),
    Breed('Airedale Terrier'),
    Breed('Akbash'),
    Breed('Akita'),
    Breed('Akita Chow'),
    Breed('Akita Pit'),
    Breed('Akita Shepherd'),
    Breed('Alaskan Klee Kai'),
    Breed('Alaskan Malamute'),
    Breed('American Bulldog'),
    Breed('American English Coonhound'),
    Breed('American Eskimo Dog'),
    Breed('American Foxhound'),
    Breed('American Hairless Terrier'),
    Breed('American Leopard Hound'),
    Breed('American Pit Bull Terrier'),
    Breed('American Pugabull'),
    Breed('American Staffordshire Terrier'),
    Breed('American Water Spaniel'),
    Breed('Anatolian Shepherd Dog'),
    Breed('Appenzeller Sennenhunde'),
    Breed('Auggie'),
    Breed('Aussiedoodle'),
    Breed('Aussiepom'),
    Breed('Australian Cattle Dog'),
    Breed('Australian Kelpie'),
    Breed('Australian Retriever'),
    Breed('Australian Shepherd'),
    Breed('Australian Shepherd Husky'),
    Breed('Australian Shepherd Lab Mix'),
    Breed('Australian Shepherd Pit Bull Mix'),
    Breed('Australian Terrier'),
    Breed('Azawakh'),
    Breed('Barbet'),
    Breed('Basenji'),
    Breed('Bassador'),
    Breed('Basset Fauve de Bretagne'),
    Breed('Basset Hound'),
    Breed('Basset Retriever'),
    Breed('Bavarian Mountain Scent Hound'),
    Breed('Beabull'),
    Breed('Beagle'),
    Breed('Beaglier'),
    Breed('Bearded Collie'),
    Breed('Bedlington Terrier'),
    Breed('Belgian Malinois'),
    Breed('Belgian Sheepdog'),
    Breed('Belgian Tervuren'),
    Breed('Berger Picard'),
    Breed('Bernedoodle'),
    Breed('Bernese Mountain Dog'),
    Breed('Bichon Frise'),
    Breed('Biewer Terrier'),
    Breed('Black and Tan Coonhound'),
    Breed('Black Mouth Cur'),
    Breed('Black Russian Terrier'),
    Breed('Bloodhound'),
    Breed('Blue Lacy'),
    Breed('Bluetick Coonhound'),
    Breed('Bocker'),
    Breed('Boerboel'),
    Breed('Boglen Terrier'),
    Breed('Bohemian Shepherd'),
    Breed('Bolognese'),
    Breed('Borador'),
    Breed('Border Collie'),
    Breed('Border Sheepdog'),
    Breed('Border Terrier'),
    Breed('Bordoodle'),
    Breed('Borzoi'),
    Breed('BoShih'),
    Breed('Bossie'),
    Breed('Boston Boxer'),
    Breed('Boston Terrier'),
    Breed('Bouvier des Flandres'),
    Breed('Boxador'),
    Breed('Boxer'),
    Breed('Boxerdoodle'),
    Breed('Boxmatian'),
    Breed('Boxweiler'),
    Breed('Boykin Spaniel'),
    Breed('Bracco Italiano'),
    Breed('Braque du Bourbonnais'),
    Breed('Briard'),
    Breed('Brittany'),
    Breed('Broholmer'),
    Breed('Brussels Griffon'),
    Breed('Bugg'),
    Breed('Bull-Pei'),
    Breed('Bull Terrier'),
    Breed('Bullador'),
    Breed('Bullboxer Pit'),
    Breed('Bulldog'),
    Breed('Bullmastiff'),
    Breed('Bullmatian'),
    Breed('Cairn Terrier'),
    Breed('Canaan Dog'),
    Breed('Cane Corso'),
    Breed('Cardigan Welsh Corgi'),
    Breed('Carolina Dog'),
    Breed('Catahoula Bulldog'),
    Breed('Catahoula Leopard Dog'),
    Breed('Caucasian Shepherd Dog'),
    Breed('Cav-a-Jack'),
    Breed('Cavachon'),
    Breed('Cavador'),
    Breed('Cavalier King Charles Spaniel'),
    Breed('Cavapoo'),
    Breed('Cesky Terrier'),
    Breed('Chabrador'),
    Breed('Cheagle'),
    Breed('Chesapeake Bay Retriever'),
    Breed('Chi Chi'),
    Breed('Chi-Poo'),
    Breed('Chigi'),
    Breed('Chihuahua'),
    Breed('Chilier'),
    Breed('Chinese Crested'),
    Breed('Chinese Shar-Pei'),
    Breed('Chinook'),
    Breed('Chion'),
    Breed('Chipin'),
    Breed('Chiweenie'),
    Breed('Chorkie'),
    Breed('Chow Chow'),
    Breed('Chow Shepherd'),
    Breed('Chug'),
    Breed('Chusky'),
    Breed('Cirneco dell’Etna'),
    Breed('Clumber Spaniel'),
    Breed('Cockalier'),
    Breed('Cockapoo'),
    Breed('Cocker Spaniel'),
    Breed('Collie'),
    Breed('Corgi Inu'),
    Breed('Corgidor'),
    Breed('Corman Shepherd'),
    Breed('Coton de Tulear'),
    Breed('Curly-Coated Retriever'),
    Breed('Dachsador'),
    Breed('Dachshund'),
    Breed('Dalmatian'),
    Breed('Dandie Dinmont Terrier'),
    Breed('Daniff'),
    Breed('Deutscher Wachtelhund'),
    Breed('Doberdor'),
    Breed('Doberman Pinscher'),
    Breed('Docker'),
    Breed('Dogo Argentino'),
    Breed('Dogue de Bordeaux'),
    Breed('Dorgi'),
    Breed('Dorkie'),
    Breed('Doxiepoo'),
    Breed('Doxle'),
    Breed('Drentsche Patrijshond'),
    Breed('Drever'),
    Breed('Dutch Shepherd'),
    Breed('English Cocker Spaniel'),
    Breed('English Foxhound'),
    Breed('English Setter'),
    Breed('English Springer Spaniel'),
    Breed('English Toy Spaniel'),
    Breed('Entlebucher Mountain Dog'),
    Breed('Estrela Mountain Dog'),
    Breed('Eurasier'),
    Breed('Field Spaniel'),
    Breed('Finnish Lapphund'),
    Breed('Finnish Spitz'),
    Breed('Flat-Coated Retriever'),
    Breed('Fox Terrier'),
    Breed('French Bulldog'),
    Breed('French Bullhuahua'),
    Breed('French Spaniel'),
    Breed('Frenchton'),
    Breed('Frengle'),
    Breed('German Pinscher'),
    Breed('German Shepherd Dog'),
    Breed('German Shepherd Pit Bull'),
    Breed('German Shepherd Rottweiler Mix'),
    Breed('German Sheprador'),
    Breed('German Shorthaired Pointer'),
    Breed('German Spitz'),
    Breed('German Wirehaired Pointer'),
    Breed('Giant Schnauzer'),
    Breed('Glen of Imaal Terrier'),
    Breed('Goberian'),
    Breed('Goldador'),
    Breed('Golden Cocker Retriever'),
    Breed('Golden Mountain Dog'),
    Breed('Golden Retriever'),
    Breed('Golden Retriever Corgi'),
    Breed('Golden Shepherd'),
    Breed('Goldendoodle'),
    Breed('Gollie'),
    Breed('Gordon Setter'),
    Breed('Great Dane'),
    Breed('Great Pyrenees'),
    Breed('Greater Swiss Mountain Dog'),
    Breed('Greyador'),
    Breed('Greyhound'),
    Breed('Hamiltonstovare'),
    Breed('Hanoverian Scenthound'),
    Breed('Harrier'),
    Breed('Havanese'),
    Breed('Hokkaido'),
    Breed('Horgi'),
    Breed('Huskita'),
    Breed('Huskydoodle'),
    Breed('Ibizan Hound'),
    Breed('Icelandic Sheepdog'),
    Breed('Irish Red and White Setter'),
    Breed('Irish Setter'),
    Breed('Irish Terrier'),
    Breed('Irish Water Spaniel'),
    Breed('Irish Wolfhound'),
    Breed('Italian Greyhound'),
    Breed('Jack-A-Poo'),
    Breed('Jack Chi'),
    Breed('Jack Russell Terrier'),
    Breed('Jackshund'),
    Breed('Japanese Chin'),
    Breed('Japanese Spitz'),
    Breed('Korean Jindo Dog'),
    Breed('Karelian Bear Dog'),
    Breed('Keeshond'),
    Breed('Kerry Blue Terrier'),
    Breed('King Shepherd'),
    Breed('Komondor'),
    Breed('Kooikerhondje'),
    Breed('Kuvasz'),
    Breed('Kyi-Leo'),
    Breed('Lab Pointer'),
    Breed('Labernese'),
    Breed('Labmaraner'),
    Breed('Labrabull'),
    Breed('Labradane'),
    Breed('Labradoodle'),
    Breed('Labrador Retriever'),
    Breed('Labrastaff'),
    Breed('Labsky'),
    Breed('Lagotto Romagnolo'),
    Breed('Lakeland Terrier'),
    Breed('Lancashire Heeler'),
    Breed('Leonberger'),
    Breed('Lhasa Apso'),
    Breed('Lhasapoo'),
    Breed('Lowchen'),
    Breed('Maltese'),
    Breed('Maltese Shih Tzu'),
    Breed('Maltipoo'),
    Breed('Manchester Terrier'),
    Breed('Mastador'),
    Breed('Mastiff'),
    Breed('Miniature Pinscher'),
    Breed('Miniature Schnauzer'),
    Breed('Morkie'),
    Breed('Mudi'),
    Breed('Mutt'),
    Breed('Neapolitan Mastiff'),
    Breed('Newfoundland'),
    Breed('Norfolk Terrier'),
    Breed('Norwegian Buhund'),
    Breed('Norwegian Elkhound'),
    Breed('Norwegian Lundehund'),
    Breed('Norwich Terrier'),
    Breed('Nova Scotia Duck Tolling Retriever'),
    Breed('Old English Sheepdog'),
    Breed('Otterhound'),
    Breed('Papillon'),
    Breed('Papipoo'),
    Breed('Peekapoo'),
    Breed('Pekingese'),
    Breed('Pembroke Welsh Corgi'),
    Breed('Petit Basset Griffon Vendeen'),
    Breed('Pharaoh Hound'),
    Breed('Pitsky'),
    Breed('Plott'),
    Breed('Pocket Beagle'),
    Breed('Pointer'),
    Breed('Polish Lowland Sheepdog'),
    Breed('Pomapoo'),
    Breed('Pomchi'),
    Breed('Pomeagle'),
    Breed('Pomeranian'),
    Breed('Pomsky'),
    Breed('Poochon'),
    Breed('Poodle'),
    Breed('Portuguese Podengo Pequeno'),
    Breed('Portuguese Water Dog'),
    Breed('Pug'),
    Breed('Pugalier'),
    Breed('Puggle'),
    Breed('Puginese'),
    Breed('Puli'),
    Breed('Pyredoodle'),
    Breed('Pyrenean Shepherd'),
    Breed('Rat Terrier'),
    Breed('Redbone Coonhound'),
    Breed('Rhodesian Ridgeback'),
    Breed('Rottador'),
    Breed('Rottle'),
    Breed('Rottweiler'),
    Breed('Saint Berdoodle'),
    Breed('Saint Bernard'),
    Breed('Saluki'),
    Breed('Samoyed'),
    Breed('Samusky'),
    Breed('Schipperke'),
    Breed('Schnoodle'),
    Breed('Scottish Deerhound'),
    Breed('Scottish Terrier'),
    Breed('Sealyham Terrier'),
    Breed('Sheepadoodle'),
    Breed('Shepsky'),
    Breed('Shetland Sheepdog'),
    Breed('Shiba Inu'),
    Breed('Shichon'),
    Breed('Shih-Poo'),
    Breed('Shih Tzu'),
    Breed('Shiloh Shepherd'),
    Breed('Shiranian'),
    Breed('Shollie'),
    Breed('Shorkie'),
    Breed('Siberian Husky'),
    Breed('Silken Windhound'),
    Breed('Silky Terrier'),
    Breed('Skye Terrier'),
    Breed('Sloughi'),
    Breed('Small Munsterlander Pointer'),
    Breed('Soft Coated Wheaten Terrier'),
    Breed('Spanish Mastiff'),
    Breed('Spinone Italiano'),
    Breed('Springador'),
    Breed('Stabyhoun'),
    Breed('Staffordshire Bull Terrier'),
    Breed('Standard Schnauzer'),
    Breed('Sussex Spaniel'),
    Breed('Swedish Vallhund'),
    Breed('Terripoo'),
    Breed('Texas Heeler'),
    Breed('Tibetan Mastiff'),
    Breed('Tibetan Spaniel'),
    Breed('Tibetan Terrier'),
    Breed('Toy Fox Terrier'),
    Breed('Treeing Tennessee Brindle'),
    Breed('Treeing Walker Coonhound'),
    Breed('Valley Bulldog'),
    Breed('Vizsla'),
    Breed('Weimaraner'),
    Breed('Welsh Springer Spaniel'),
    Breed('Welsh Terrier'),
    Breed('West Highland White Terrier'),
    Breed('Westiepoo'),
    Breed('Whippet'),
    Breed('Whoodle'),
    Breed('Wirehaired Pointing Griffon'),
    Breed('Xoloitzcuintli'),
    Breed('Yorkipoo'),
    Breed('Yorkshire Terrier'),
  ];
  var items = List<String>();
  String selectedBreed = '';
  bool _isVisible = true;

  @override
  void initState() {
    duplicateItems.forEach((item) {
      items.add(item.breed);
    });
    editingController.addListener(() {
      setState(() {
        filter = editingController.text;
      });
    });

    super.initState();
  }

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
        title: Text('Breed'),
        backgroundColor: Theme.of(context).accentColor,
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
        child: Column(
          children: <Widget>[
            Text(
              "Select a breed from the list below",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
            Container(
                color: Colors.grey,
                width: 420,
                height: 200,
                child: Card(
                  child: new ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      String c = items?.elementAt(index);
                      return filter == null || filter == ""
                          ? new Card(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    selectedBreed = c;
                                  });
                                },
                                leading: CircleAvatar(
                                    child: Icon(FontAwesomeIcons.dog)),
                                title: Text(items[index] ?? ""),
                              ),
                            )
                          : items[index]
                                  .toLowerCase()
                                  .contains(filter.toLowerCase())
                              ? new Card(
                                  elevation: 8.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        selectedBreed = c;
                                      });
                                    },
                                    leading: CircleAvatar(
                                        child: Icon(FontAwesomeIcons.dog)),
                                    title: Text(items[index] ?? ""),
                                  ),
                                )
                              : new Container();
                    },
                  ),
                )),
            Container(
              width: 300,
              height: 65,
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search Breed",
                    hintText: "ex: Whippet",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  child: Image.asset("logopurplepink.png"),
                ),
                Text(
                  "Selected breed: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            if (selectedBreed != "")
              Card(
                color: colorPeachPink,
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  leading: CircleAvatar(child: Icon(FontAwesomeIcons.dog)),
                  title: Text(selectedBreed),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class InputPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("             Add Dog")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
                margin: EdgeInsets.all(10),
                elevation: 20,
                child: Container(width: 420, height: 120, child: NameSelect())),
            Card(
                margin: EdgeInsets.all(10),
                elevation: 20,
                child: Container(width: 420, height: 520, child: BuildCards())),
            // _buildBottom(context),
            Card(
                margin: EdgeInsets.all(10),
                elevation: 20,
                child:
                    Container(width: 420, height: 500, child: SearchBreeds())),
            Card(
                margin: EdgeInsets.all(10),
                elevation: 20,
                child:
                    Container(width: 420, height: 400, child: DogPictures())),
          ],
        ),
      ),
    );
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
    return Container(
      alignment: Alignment.center,
      height: screenAwareSize(108.0, context),
      width: double.infinity,
      child: Switch(value: true, onChanged: (val) {}),
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
          backgroundColor: Theme.of(context).accentColor,
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
                            Expanded(child: GenderCard()),
                            Expanded(child: AgeCard()),
                            Expanded(
                              child: WeightCard(),
                            )
                          ],
                        ),
                      ),
                      Expanded(child: HeightCard())
                    ],
                  ),
                )
              ],
            )));
  }
}

class DogPictures extends StatefulWidget {
  const DogPictures({Key key}) : super(key: key);

  @override
  DogPicturesState createState() => DogPicturesState();
}

class DogPicturesState extends State<DogPictures> {
  String _path = null;

  void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _path = file.path;
    });
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 60,
              child: Column(children: <Widget>[
                ListTile(
                  onTap: _showPhotoLibrary,
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library")),
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.verified_user),
        elevation: 0,
        title: Text('Add Pictures'),
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                child: Image.asset("logopurplepink.png"),
              ),
              FlatButton(
                child: Text(
                  "Add a picture of your dog: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                color: colorPurple,
                onPressed: () {
                  _showOptions(context);
                },
              ),
            ],
          ),
          Container(
            color: Colors.black,
            width: 420,
            height: 250,
            child: _path == null
                ? Icon(Icons.photo, size: 200,)
                : Image.file(File(_path)),
          )
        ],
      ),
    );
  }
}

class AgeCard extends StatefulWidget {
  final int initialAge;

  const AgeCard({Key key, this.initialAge}) : super(key: key);

  @override
  _AgeCardState createState() => _AgeCardState();
}

class _AgeCardState extends State<AgeCard> {
  int age;

  @override
  void initState() {
    super.initState();
    age = widget.initialAge ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(32.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle(
              "Age",
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenAwareSize(16.0, context)),
                  child: _drawSlider(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawSlider() {
    return AgeBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.isTight
              ? Container()
              : AgeSlider(
                  minValue: 0,
                  maxValue: 19,
                  value: age,
                  onChanged: (val) => setState(() => age = val),
                  width: constraints.maxWidth,
                );
        },
      ),
    );
  }
}

class AgeBackground extends StatelessWidget {
  final Widget child;

  const AgeBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: screenAwareSize(100.0, context),
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius:
                new BorderRadius.circular(screenAwareSize(50.0, context)),
          ),
          child: child,
        ),
        SvgPicture.asset(
          "assets/weight_arrow.svg",
          height: screenAwareSize(10.0, context),
          width: screenAwareSize(18.0, context),
        ),
      ],
    );
  }
}

class AgeSlider extends StatelessWidget {
  AgeSlider({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.value,
    @required this.onChanged,
    @required this.width,
  })  : scrollController = new ScrollController(
          initialScrollOffset: (value - minValue) * width / 3,
        ),
        super(key: key);

  final int minValue;
  final int maxValue;
  final int value;
  final ValueChanged<int> onChanged;
  final double width;
  final ScrollController scrollController;

  double get itemExtent => width / 3;

  int _indexToValue(int index) => minValue + (index - 1);

  @override
  build(BuildContext context) {
    int itemCount = (maxValue - minValue) + 3;
    return NotificationListener(
      onNotification: _onNotification,
      child: new ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          int itemValue = _indexToValue(index);
          bool isExtra = index == 0 || index == itemCount - 1;

          return isExtra
              ? new Container() //empty first and last element
              : GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _animateTo(itemValue, durationMillis: 50),
                  child: FittedBox(
                    child: Text(
                      itemValue.toString(),
                      style: _getTextStyle(context, itemValue),
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                );
        },
      ),
    );
  }

  TextStyle _getDefaultTextStyle() {
    return new TextStyle(
      color: Color.fromRGBO(196, 197, 203, 1.0),
      fontSize: 14.0,
    );
  }

  TextStyle _getHighlightTextStyle(BuildContext context) {
    return new TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 28.0,
    );
  }

  TextStyle _getTextStyle(BuildContext context, int itemValue) {
    return itemValue == value
        ? _getHighlightTextStyle(context)
        : _getDefaultTextStyle();
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  _animateTo(int valueToSelect, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: new Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }

  int _offsetToMiddleIndex(double offset) => (offset + width / 2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue = math.max(minValue, math.min(maxValue, middleValue));
    return middleValue;
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);

      if (_userStoppedScrolling(notification)) {
        _animateTo(middleValue);
      }

      if (middleValue != value) {
        onChanged(middleValue); //update selection
      }
    }
    return true;
  }
}

class HeightCard extends StatefulWidget {
  final int height;

  const HeightCard({Key key, this.height}) : super(key: key);

  @override
  HeightCardState createState() => HeightCardState();
}

class HeightCardState extends State<HeightCard> {
  int height;

  @override
  void initState() {
    super.initState();
    height = widget.height ?? 40;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle("HEIGHT", subtitle: "(cm)"),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenAwareSize(8.0, context)),
                child: LayoutBuilder(builder: (context, constraints) {
                  return HeightPicker(
                    widgetHeight: constraints.maxHeight,
                    height: height,
                    onChange: (val) => setState(() => height = val),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeightPicker extends StatefulWidget {
  final int maxHeight;
  final int minHeight;
  final int height;
  final double widgetHeight;
  final ValueChanged<int> onChange;

  const HeightPicker(
      {Key key,
      this.height,
      this.widgetHeight,
      this.onChange,
      this.maxHeight = 110,
      this.minHeight = 15})
      : super(key: key);

  int get totalUnits => maxHeight - minHeight;

  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  double startDragYOffset;
  int startDragHeight;

  double get _pixelsPerUnit {
    return _drawingHeight / widget.totalUnits;
  }

  double get _sliderPosition {
    double halfOfBottomLabel = labelsFontSize / 2;
    int unitsFromBottom = widget.height - widget.minHeight;
    return halfOfBottomLabel + unitsFromBottom * _pixelsPerUnit;
  }

  ///returns actual height of slider to be able to slide
  double get _drawingHeight {
    double totalHeight = widget.widgetHeight;
    double marginBottom = marginBottomAdapted(context);
    double marginTop = marginTopAdapted(context);
    return totalHeight - (marginBottom + marginTop + labelsFontSize);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: _onTapDown,
      onVerticalDragStart: _onDragStart,
      onVerticalDragUpdate: _onDragUpdate,
      child: Stack(
        children: <Widget>[
          _drawPersonImage(),
          _drawSlider(),
          _drawLabels(),
        ],
      ),
    );
  }

  _onTapDown(TapDownDetails tapDownDetails) {
    int height = _globalOffsetToHeight(tapDownDetails.globalPosition);
    widget.onChange(_normalizeHeight(height));
  }

  int _normalizeHeight(int height) {
    return math.max(widget.minHeight, math.min(widget.maxHeight, height));
  }

  int _globalOffsetToHeight(Offset globalOffset) {
    RenderBox getBox = context.findRenderObject();
    Offset localPosition = getBox.globalToLocal(globalOffset);
    double dy = localPosition.dy;
    dy = dy - marginTopAdapted(context) - labelsFontSize / 2;
    int height = widget.maxHeight - (dy ~/ _pixelsPerUnit);
    return height;
  }

  _onDragStart(DragStartDetails dragStartDetails) {
    int newHeight = _globalOffsetToHeight(dragStartDetails.globalPosition);
    widget.onChange(newHeight);
    setState(() {
      startDragYOffset = dragStartDetails.globalPosition.dy;
      startDragHeight = newHeight;
    });
  }

  _onDragUpdate(DragUpdateDetails dragUpdateDetails) {
    double currentYOffset = dragUpdateDetails.globalPosition.dy;
    double verticalDifference = startDragYOffset - currentYOffset;
    int diffHeight = verticalDifference ~/ _pixelsPerUnit;
    int height = _normalizeHeight(startDragHeight + diffHeight);
    setState(() => widget.onChange(height));
  }

  Widget _drawSlider() {
    return Positioned(
      child: HeightSlider(height: widget.height),
      left: 0.0,
      right: 0.0,
      bottom: _sliderPosition,
    );
  }

  Widget _drawLabels() {
    int labelsToDisplay = widget.totalUnits ~/ 5 + 1;
    List<Widget> labels = List.generate(
      labelsToDisplay,
      (idx) {
        return Text(
          "${widget.maxHeight - 5 * idx}",
          style: labelsTextStyle,
        );
      },
    );

    return Align(
      alignment: Alignment.centerRight,
      child: IgnorePointer(
        child: Padding(
          padding: EdgeInsets.only(
            right: screenAwareSize(12.0, context),
            bottom: marginBottomAdapted(context),
            top: marginTopAdapted(context),
          ),
          child: Column(
            children: labels,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ),
    );
  }

  Widget _drawPersonImage() {
    double personImageHeight = _sliderPosition + marginBottomAdapted(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: SvgPicture.asset(
        "assets/Dog.svg",
        height: personImageHeight,
        width: personImageHeight / 3,
      ),
    );
  }
}

class HeightSlider extends StatelessWidget {
  final int height;

  const HeightSlider({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SliderLabel(height: height),
          Row(
            children: <Widget>[
              SliderCircle(),
              Expanded(child: SliderLine()),
            ],
          ),
        ],
      ),
    );
  }
}

class SliderLabel extends StatelessWidget {
  final int height;

  const SliderLabel({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenAwareSize(4.0, context),
        bottom: screenAwareSize(2.0, context),
      ),
      child: Text(
        "$height",
        style: TextStyle(
          fontSize: selectedLabelFontSize,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SliderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
          40,
          (i) => Expanded(
                child: Container(
                  height: 2.0,
                  decoration: BoxDecoration(
                      color: i.isEven
                          ? Theme.of(context).primaryColor
                          : Colors.white),
                ),
              )),
    );
  }
}

class SliderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSizeAdapted(context),
      height: circleSizeAdapted(context),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.unfold_more,
        color: Colors.white,
        size: 0.6 * circleSizeAdapted(context),
      ),
    );
  }
}

double marginBottomAdapted(BuildContext context) =>
    screenAwareSize(marginBottom, context);

double marginTopAdapted(BuildContext context) =>
    screenAwareSize(marginTop, context);

double circleSizeAdapted(BuildContext context) =>
    screenAwareSize(circleSize, context);

const TextStyle labelsTextStyle = const TextStyle(
  color: labelsGrey,
  fontSize: labelsFontSize,
);

const double circleSize = 32.0;
const double marginBottom = circleSize / 2;
const double marginTop = 26.0;
const double selectedLabelFontSize = 14.0;
const double labelsFontSize = 13.0;
const Color labelsGrey = const Color.fromRGBO(216, 217, 223, 1.0);

class GenderCard extends StatefulWidget {
  final Gender initialGender;

  const GenderCard({Key key, this.initialGender}) : super(key: key);

  @override
  _GenderCardState createState() => _GenderCardState();
}

const double _defaultGenderAngle = math.pi / 4;
const Map<Gender, double> _genderAngles = {
  Gender.female: -_defaultGenderAngle,
  Gender.male: _defaultGenderAngle,
};

double _circleSize(BuildContext context) => screenAwareSize(80.0, context);

class _GenderCardState extends State<GenderCard>
    with SingleTickerProviderStateMixin {
  AnimationController _arrowAnimationController;
  Gender selectedGender;

  @override
  void initState() {
    selectedGender = widget.initialGender;
    _arrowAnimationController = new AnimationController(
      vsync: this,
      lowerBound: -_defaultGenderAngle,
      upperBound: _defaultGenderAngle,
      value: _genderAngles[selectedGender],
    );
    super.initState();
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(12.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle("GENDER"),
            Padding(
              padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
              child: _drawMainStack(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawMainStack() {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _drawCircleIndicator(),
          GenderIconTranslated(gender: Gender.female),
          GenderIconTranslated(gender: Gender.male),
          _drawGestureDetector(),
        ],
      ),
    );
  }

  Widget _drawCircleIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GenderCircle(),
        GenderArrow(listenable: _arrowAnimationController),
      ],
    );
  }

  _drawGestureDetector() {
    return Positioned.fill(
      child: TapHandler(
        onGenderTapped: _setSelectedGender,
      ),
    );
  }

  void _setSelectedGender(Gender gender) {
    setState(() => selectedGender = gender);
    _arrowAnimationController.animateTo(
      _genderAngles[gender],
      duration: Duration(milliseconds: 150),
    );
  }
}

class GenderIconTranslated extends StatelessWidget {
  static final Map<Gender, String> _genderImages = {
    Gender.female: "assets/gender_female.svg",
    Gender.male: "assets/gender_male.svg",
  };

  final Gender gender;

  const GenderIconTranslated({Key key, this.gender}) : super(key: key);

  bool get _isOtherGender => gender == Gender.other;

  String get _assetName => _genderImages[gender];

  double _iconSize(BuildContext context) {
    return screenAwareSize(_isOtherGender ? 22.0 : 16.0, context);
  }

  double _genderLeftPadding(BuildContext context) {
    return screenAwareSize(_isOtherGender ? 8.0 : 0.0, context);
  }

  @override
  Widget build(BuildContext context) {
    Widget icon = Padding(
      padding: EdgeInsets.only(left: _genderLeftPadding(context)),
      child: SvgPicture.asset(
        _assetName,
        height: _iconSize(context),
        width: _iconSize(context),
      ),
    );

    Widget rotatedIcon = Transform.rotate(
      angle: -_genderAngles[gender],
      child: icon,
    );

    Widget iconWithALine = Padding(
      padding: EdgeInsets.only(bottom: _circleSize(context) / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          rotatedIcon,
          GenderLine(),
        ],
      ),
    );

    Widget rotatedIconWithALine = Transform.rotate(
      alignment: Alignment.bottomCenter,
      angle: _genderAngles[gender],
      child: iconWithALine,
    );

    Widget centeredIconWithALine = Padding(
      padding: EdgeInsets.only(bottom: _circleSize(context) / 2),
      child: rotatedIconWithALine,
    );

    return centeredIconWithALine;
  }
}

class GenderArrow extends AnimatedWidget {
  const GenderArrow({Key key, Listenable listenable})
      : super(key: key, listenable: listenable);

  double _arrowLength(BuildContext context) => screenAwareSize(32.0, context);

  double _translationOffset(BuildContext context) =>
      _arrowLength(context) * -0.4;

  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Transform.rotate(
      angle: animation.value,
      child: Transform.translate(
        offset: Offset(0.0, _translationOffset(context)),
        child: Transform.rotate(
          angle: -_defaultGenderAngle,
          child: SvgPicture.asset(
            "assets/gender_arrow.svg",
            height: _arrowLength(context),
            width: _arrowLength(context),
          ),
        ),
      ),
    );
  }
}

class TapHandler extends StatelessWidget {
  final Function(Gender) onGenderTapped;

  const TapHandler({Key key, this.onGenderTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            child: GestureDetector(onTap: () => onGenderTapped(Gender.female))),
        Expanded(
            child: GestureDetector(onTap: () => onGenderTapped(Gender.male))),
      ],
    );
  }
}

class GenderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _circleSize(context),
      height: _circleSize(context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(244, 244, 244, 1.0),
      ),
    );
  }
}

class GenderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: screenAwareSize(6.0, context),
        top: screenAwareSize(8.0, context),
      ),
      child: Container(
        height: screenAwareSize(8.0, context),
        width: 1.0,
        color: Color.fromRGBO(216, 217, 223, 0.54),
      ),
    );
  }
}

class WeightCard extends StatefulWidget {
  final int initialWeight;

  const WeightCard({Key key, this.initialWeight}) : super(key: key);

  @override
  _WeightCardState createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
  int weight;

  @override
  void initState() {
    super.initState();
    weight = widget.initialWeight ?? 15;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(32.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle(
              "Weight",
              subtitle: "(kg)",
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenAwareSize(16.0, context)),
                  child: _drawSlider(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawSlider() {
    return WeightBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.isTight
              ? Container()
              : WeightSlider(
                  minValue: 1,
                  maxValue: 80,
                  value: weight,
                  onChanged: (val) => setState(() => weight = val),
                  width: constraints.maxWidth,
                );
        },
      ),
    );
  }
}

class WeightBackground extends StatelessWidget {
  final Widget child;

  const WeightBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: screenAwareSize(100.0, context),
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius:
                new BorderRadius.circular(screenAwareSize(50.0, context)),
          ),
          child: child,
        ),
        SvgPicture.asset(
          "assets/weight_arrow.svg",
          height: screenAwareSize(10.0, context),
          width: screenAwareSize(18.0, context),
        ),
      ],
    );
  }
}

class WeightSlider extends StatelessWidget {
  WeightSlider({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.value,
    @required this.onChanged,
    @required this.width,
  })  : scrollController = new ScrollController(
          initialScrollOffset: (value - minValue) * width / 3,
        ),
        super(key: key);

  final int minValue;
  final int maxValue;
  final int value;
  final ValueChanged<int> onChanged;
  final double width;
  final ScrollController scrollController;

  double get itemExtent => width / 3;

  int _indexToValue(int index) => minValue + (index - 1);

  @override
  build(BuildContext context) {
    int itemCount = (maxValue - minValue) + 3;
    return NotificationListener(
      onNotification: _onNotification,
      child: new ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          int itemValue = _indexToValue(index);
          bool isExtra = index == 0 || index == itemCount - 1;

          return isExtra
              ? new Container() //empty first and last element
              : GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _animateTo(itemValue, durationMillis: 50),
                  child: FittedBox(
                    child: Text(
                      itemValue.toString(),
                      style: _getTextStyle(context, itemValue),
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                );
        },
      ),
    );
  }

  TextStyle _getDefaultTextStyle() {
    return new TextStyle(
      color: Color.fromRGBO(196, 197, 203, 1.0),
      fontSize: 14.0,
    );
  }

  TextStyle _getHighlightTextStyle(BuildContext context) {
    return new TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 28.0,
    );
  }

  TextStyle _getTextStyle(BuildContext context, int itemValue) {
    return itemValue == value
        ? _getHighlightTextStyle(context)
        : _getDefaultTextStyle();
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  _animateTo(int valueToSelect, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: new Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }

  int _offsetToMiddleIndex(double offset) => (offset + width / 2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue = math.max(minValue, math.min(maxValue, middleValue));
    return middleValue;
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);

      if (_userStoppedScrolling(notification)) {
        _animateTo(middleValue);
      }

      if (middleValue != value) {
        onChanged(middleValue); //update selection
      }
    }
    return true;
  }
}
