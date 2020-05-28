import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/mapFiles/mapsDemo.dart';
import 'package:frontend/loginFiles/MySignInPage.dart';
import 'package:provider/provider.dart';

import 'package:frontend/loadingScreen.dart';

class Wrapper extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context); // Getting user data from the provider.
    // return home scrren eller authenticate widget.
    //https://youtu.be/z05m8nlPRxk?t=394  

    print('User :');
    print(user);
    

    if (user == null) {
      return MySignInPage();
    } else {
      return LoadingScreen(user);
    }
    
  }
}