import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter login UI',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
        ));
    //       border:
    //           OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    // );
    final passwordField = TextField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
        ));
    //       border:
    //           OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    // );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondRoute()),
          );
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final mailButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondRoute()),
          );
        },
        child: Text("Create an account",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.purpleAccent,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 90.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20.0),
                emailField,
                SizedBox(height: 20.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 5.0,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondRoute()),
                    );
                  },
                  child: new Text("Forgot Password?"),
                ),
                Text(
                  'OR',
                  textAlign: TextAlign.center,
                ),
                // Text(
                //   'Forgot password?',
                //   textAlign: TextAlign.center,
                // ),
                // SizedBox(height: 10.0), forgotPassword,
                SignInButton(
                  Buttons.Facebook,
                  text: "Sign up with Facebook",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondRoute()),
                    );
                  },
                ),
                // SizedBox(height: 10.0), facebookButton,
                // SizedBox(height: 10.0), googleButton,
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondRoute()),
                    );
                  },
                ),
                SizedBox(height: 5.0), mailButton,
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondRoute()),
                    );
                  },
                  child: new Text("Continue without login >", textAlign: TextAlign.right),
                  
                ),
//                     Row(
//   mainAxisAlignment: MainAxisAlignment.spaceAround,
//   children: const <Widget>[
//     Icon(
//       Icons.favorite,
//       color: Colors.pink,
//       size: 24.0,
//       semanticLabel: 'Text to announce in accessibility modes',
//     ),
//     Icon(
//       Icons.audiotrack,
//       color: Colors.green,
//       size: 30.0,
//     ),
//     Icon(
//       Icons.beach_access,
//       color: Colors.blue,
//       size: 36.0,
//     ),
//   ],
// )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stockholm Light"),
        ),
        body: Center(
            child: Container(
          color: Colors.purpleAccent,
          child: SizedBox(
            height: 170.0,
            child: Image.asset(
              "assets/mapPlaceholder.png",
              fit: BoxFit.contain,
            ),
          ),
        )));
  }
}
