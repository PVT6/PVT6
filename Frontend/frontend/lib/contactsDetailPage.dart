import 'package:flutter/material.dart';

import 'package:frontend/updateContacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:contacts_service/contacts_service.dart';

import 'addPet.dart';

class ContactDetailsPage extends StatelessWidget {
  //tycker inte grönt tema passar jättebra på denna klass, prata ihop om ett allmänt tema för appen senare i projektet
  ContactDetailsPage(this._contact);
  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_contact.displayName ?? ""),
        backgroundColor: Colors.blue,
        actions: <Widget>[ //vill inte ha denna funktion
          // IconButton(
          //   icon: Icon(Icons.delete),
          //   onPressed: () => ContactsService.deleteContact(_contact),
          // ),
          IconButton(
            icon: Icon(Icons.update),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UpdateContactsPage(
                  contact: _contact,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        //använd kommentarer nedan för att se hur man använder objects från kontakter!
        // child: ListView(
        //   children: <Widget>[
        //     ListTile(
        //       title: Text("Name"),
        //       trailing: Text(_contact.givenName ?? ""),
        //     ),
        //     ListTile(
        //       title: Text("Last Name"),
        //       trailing: Text(_contact.familyName ?? ""),
        //     ),
        //     ItemsTile("Phones", _contact.phones),
        //     ItemsTile("Emails", _contact.emails),
        //     SwitchListTile(
        //       activeColor: Colors.green[900],
        //       contentPadding: const EdgeInsets.all(0),
        //       value: true,
        //       title: Text("Allow Location Sharing"),
        //       onChanged: (val) {},
        //     ),
        //   ],
        // ),
        child: ListView(
          children: <Widget>[
            // Container(
            //   height: 200,
            //   decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //           begin: Alignment.centerLeft,
            //           end: Alignment.centerRight,
            //           stops: [0.5, 0.9],
            //           colors: [Colors.red, Colors.deepOrange.shade300])),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: <Widget>[
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: <Widget>[
            //           CircleAvatar(
            //             child: Icon(
            //               Icons.call,
            //               size: 30.0,
            //             ),
            //             minRadius: 30.0,
            //             backgroundColor: Colors.red.shade600,
            //           ),
            //           (_contact.avatar != null && _contact.avatar.length > 0)
            //               ? CircleAvatar(
            //                   minRadius: 60,
            //                   backgroundColor: Colors.deepOrange.shade300,
            //                   backgroundImage: MemoryImage(_contact.avatar))
            //               : CircleAvatar(
            //                   minRadius: 60,
            //                   backgroundColor: Colors.deepOrange.shade300,
            //                   child: Text(_contact.initials())),
            //           // CircleAvatar(
            //           //   minRadius: 60,
            //           //   backgroundColor: Colors.deepOrange.shade300,
            //           //   child: CircleAvatar(
            //           //     backgroundImage:
            //           //         new AssetImage('assets/googleLoginMini.png'),
            //           //     minRadius: 50,
            //           //   ),
            //           // ),
            //           CircleAvatar(
            //             child: Icon(
            //               Icons.message,
            //               size: 30.0,
            //             ),
            //             minRadius: 30.0,
            //             backgroundColor: Colors.red.shade600,
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Text(
            //         _contact.familyName ?? "",
            //         style: TextStyle(fontSize: 22.0, color: Colors.white),
            //       ),
            //       Text(
            //         _contact.givenName ?? "",
            //         style:
            //             TextStyle(fontSize: 14.0, color: Colors.red.shade700),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   // height: 50,
            //   child: Row(
            //     children: <Widget>[
            //       Expanded(
            //         child: Container(
            //           color: Colors.deepOrange.shade300,
            //           child: ListTile(
            //             title: Text(
            //               "50895m",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 24.0),
            //             ),
            //             subtitle: Text(
            //               "Distance",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(color: Colors.red),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Container(
            //           color: Colors.red,
            //           child: ListTile(
            //             title: Text(
            //               "Årsta",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 24.0),
            //             ),
            //             subtitle: Text(
            //               "Stockholm",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(color: Colors.white70),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            ProfileHeader(
              avatar: new MemoryImage(_contact.avatar), //userData
              coverImage: new MemoryImage(_contact.avatar), //userData
              title:
                  _contact.displayName, //userData
              subtitle: "Dog lover",
              actions: <Widget>[
                //Row med items
                MaterialButton(
                  color: Colors.white,
                  shape: CircleBorder(),
                  elevation: 0,
                  child: Icon(Icons.edit),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 230,
                ),
                MaterialButton(
                  color: Colors.white,
                  shape: CircleBorder(),
                  elevation: 0,
                  child: Icon(Icons.pets),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddDog()),
                    );
                  },
                ),
              ],
            ),
            ItemsTile("Emails", _contact.emails),
            Divider(),
            ItemsTile("Phones", _contact.phones),
            Divider(),
            ListTile(
              title: Text(
                "Facebook",
                style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
              ),
              subtitle: Text(
                "facebook.com/MinFaceBook",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class ItemsTile extends StatelessWidget {
  ItemsTile(this._title, this._items);
  final Iterable<Item> _items;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(title: Text(_title)),
        Column(
          children: _items
              .map(
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                    title: Text(i.label ?? ""),
                    trailing: Text(i.value ?? ""),
                  ),
                ),
              )
              .toList(),
        ),
      ],
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
