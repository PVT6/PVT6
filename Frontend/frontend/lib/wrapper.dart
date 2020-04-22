import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context); // Getting user data from the provider.
    // return home scrren eller authenticate widget.
    //https://youtu.be/z05m8nlPRxk?t=394  
    

    if (user == null) {
      return Authenticate();
    } else {
      //Byt ut "Authenticate" till våran hem skärm.
      return Authenticate(); // ska skicka användaren till hem skärmen
    }
    
  }
}