import 'package:flutter/material.dart';

import 'dogProfile.dart';

List<User> friends;
List<User> users = [
  User('Jakob', "123@gmail.com", '123',true),
  User('Sharon', "123@gmail.com", '123',false),
  User('Erik', "123@gmail.com", '123',true)
];

class FriendsPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<FriendsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Friends Page"),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
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
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //lägga till specifik användare om man kan namnet(behöver egen page)
        },
      ),
      body: TabBarView(
        children: [
          SafeArea(
            child: friends != null
                ? ListView.builder(
                    itemCount: friends?.length ??
                        0, //lägga till vår egen lista på denna bör funka
                    itemBuilder: (BuildContext context, int index) {
                      User c = friends?.elementAt(index);
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProfileInfo(c)));
                        },
                        leading: CircleAvatar(child: Text("PH")),
                        title: Text(c.name ?? ""),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          SafeArea(
            child: users != null
                ? ListView.builder(
                    itemCount: users?.length ??
                        0, //lägga till vår egen lista på denna bör funka
                    itemBuilder: (BuildContext context, int index) {
                      User c = users?.elementAt(index);
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProfileInfo(c)));
                        },
                        leading: CircleAvatar(child: Text("PH")),
                        title: Text(c.name ?? ""),
                        trailing: IconButton(
                            icon: Icon(
                              Icons.person_add,
                              color: Colors.green,
                              size: 37,
                            ),
                            onPressed:
                                null), //onPressed Lägger till i vänner och tar bort från lista
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          SearchUsers()
        ],
        controller: _tabController,
      ),
    );
  }
}

class User {
  final String name;
  final String email;
  final String phone;
  bool friendstatus;

  User(this.name, this.email, this.phone,this.friendstatus);
}

class SearchUsers extends StatefulWidget {
  SearchUsers({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<SearchUsers> {
  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${items[index]}'),
                  );
                },
              ),
            ),
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
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ProfileHeader(
              avatar: new AssetImage("profilePH.png"), //userData
              coverImage: new AssetImage("backgroundStockholm.png"), //userData
              title: widget.user.name, //userData
              subtitle: "Dog lover",
              actions: <Widget>[
                //Row med items

                SizedBox(
                  width: 230,
                ),
                widget.user.friendstatus != false
                    ? MaterialButton(
                        color: Colors.green,
                        shape: BeveledRectangleBorder(),
                        elevation: 0,
                        child: Icon(Icons.person_add),
                        onPressed: () {
                           setState(() {
                            widget.user.friendstatus = false;
                          });
                        },
                      )
                    : MaterialButton(
                        color: Colors.red,
                        shape: BeveledRectangleBorder(),
                        elevation: 0,
                        child: Icon(Icons.remove_circle),
                        onPressed: () {
                          setState(() {
                            widget.user.friendstatus = true;
                          });
                        },
                      ),
              ],
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "My Dogs",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    //user hundlista här
                    children: <Widget>[
                      SizedBox(
                          child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DogProfile()),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              'BrewDog.jpg',
                            ),
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DogProfile()),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              'LeBistro.jpg',
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "User Information", //userData
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Card(
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
                                    leading: Icon(Icons.my_location),
                                    title: Text(
                                      "Location",
                                      style: TextStyle(
                                          color: Colors.blue.shade300),
                                    ),
                                    subtitle: Text(
                                      "Stockholm",
                                      style: TextStyle(
                                          color: Colors.blue.shade300),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.email),
                                    title: Text(
                                      "Email",
                                      style: TextStyle(
                                          color: Colors.blue.shade300),
                                    ),
                                    subtitle: Text(
                                      widget.user.email,
                                      style: TextStyle(
                                          color: Colors.blue.shade300),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.phone),
                                    title: Text(
                                      "Phone",
                                      style: TextStyle(
                                          color: Colors.blue.shade300),
                                    ),
                                    subtitle: Text(
                                      widget.user.phone,
                                      style: TextStyle(
                                          color: Colors.blue.shade300),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(
                                      "About Me",
                                      style: TextStyle(
                                          color: Colors.blue.shade300),
                                    ),
                                    subtitle: Text(
                                      "I love big fluffy dogs. Proud owner of a Bernese Mountain Dog",
                                      style: TextStyle(
                                          color: Colors.blue.shade300),
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
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const ProfileHeader(
      {Key key,
      @required this.coverImage,
      @required this.avatar,
      @required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
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
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 60,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ]
            ],
          ),
        )
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
