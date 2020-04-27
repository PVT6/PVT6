import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/services/auth.dart';
import 'MySignInPage.dart';
import 'package:provider/provider.dart';
import 'wrapper.dart';
import 'package:flutter_config/flutter_config.dart';

Color darkGreen = Colors.green[900];
Color lightGreen = Colors.green[100];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();
   runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
 Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}


