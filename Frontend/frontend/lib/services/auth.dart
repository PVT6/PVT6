import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../user.dart' as userlib;



class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //Facebook sign in
  FacebookLogin fbLogin = new FacebookLogin();

// auth chnage user stream
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

// sign in with email & password

// register with email & password

Future registerWithEmailAndPassword(String email, String password, String phone, String lastname, String firstname) async { //Kan lägga till mer saker sen.
try {
  AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  FirebaseUser user = result.user;
  

  var url = 'https://group6-15.pvt.dsv.su.se/user/new';

  var response = await http.post(Uri.parse(url),  body: {'uid': user.uid, 'email': email, 'phone': phone, 'name': firstname+" "+lastname});

  print(response.body);
  if (response.statusCode == 200){
    userlib.setName(firstname+" "+lastname);
    userlib.setPhone(phone);
    userlib.setEmail(email);
    userlib.setLogin(true);
  }
  else {
    throw("FAILED TO CONNECT TO DB");
  }
  return user;
}catch(e){
  print(e.toString());
  return null;
}
}

Future signInWithEmailAndPassword(String email, String password) async { //Kan lägga till mer saker sen.
try {
  AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
  FirebaseUser user = result.user;
  var url = 'https://group6-15.pvt.dsv.su.se/user/find?uid=${user.uid}';

   var response = await http.get(Uri.parse(url));
    if (response.body != ""){
      var user = json.decode(response.body);
      userlib.setName(user['name']);
      userlib.setPhone(user['phoneNumber']);
      userlib.setEmail(user['email']);
      userlib.setLogin(true);
  }
  else {
    throw("FAILED TO CONNECT TO DB or Non user found");
  }
  return user;
}catch(e){
  print(e.toString());
  return null;
}

}

// sign out
Future signOut() async {
  try {
    await _googleSignIn.signOut();
    await fbLogin.logOut();
    return await _auth.signOut();
  } catch(e){
    print(e.toString());
    return null;
  }
}

//More sign in methods. 

//Facebook sign in
Future facebookSignIn() async {
  try {
    final facebookLoginResult = await fbLogin
                .logIn(['email', 'public_profile']);
                      FacebookAccessToken myToken = facebookLoginResult.accessToken;
                                            //assuming sucess in FacebookLoginStatus.loggedIn
                                            // we use FacebookAuthProvider class to get a credential from accessToken
                                            // this will return an AuthCredential object that we will use to auth in firebase
                        AuthCredential credential= FacebookAuthProvider.getCredential(accessToken: myToken.token);
                                            // this line do auth in firebase with your facebook credential.
                                    FirebaseUser firebaseUser = (
                                      await FirebaseAuth.instance.signInWithCredential(credential)
                                       ).user;
                                       userExistsOrNot(firebaseUser);
                                       return firebaseUser;
   
  }
  catch(e){
      print("error signing in with Facebook");
      return null;
    }
}


//Google sign in
Future googleSignIn() async {
  try {
    GoogleSignInAccount account = await _googleSignIn.signIn();
    AuthResult result = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
      idToken: (await account.authentication).idToken,
      accessToken: (await account.authentication).accessToken
      ));
    FirebaseUser user = result.user;
    userExistsOrNot(user);
    return user;
  } catch(e) {
    print("Error logging in with google.");
    return null;
  }
}



// Reset Password
Future sendPasswordResetEmail(String email) async {
  try {
    return await _auth.sendPasswordResetEmail(email: email);
  } catch(e){
    print(e.toString());
    return null;
  }
}

Future userExistsOrNot(FirebaseUser user) async {
  var url = 'https://group6-15.pvt.dsv.su.se/user/find?uid=${user.uid}';
  var response = await http.get(Uri.parse(url));

  if (response.body != ""){
      var user = json.decode(response.body);
      userlib.setName(user['name']);
      userlib.setPhone(user['phoneNumber']);
      userlib.setEmail(user['email']);
      userlib.setLogin(true);
  } else {
     url = 'https://group6-15.pvt.dsv.su.se/user/new';

     var response = await http.post(Uri.parse(url),  body: {'uid': user.uid, 'email': user.email, 'phone': "", 'name': user.displayName});

     print(response.body);
     if (response.statusCode == 200){
         userlib.setName(user.displayName);
         userlib.setPhone("");
         userlib.setEmail(user.email);
         userlib.setLogin(true);
       }else {
    throw("FAILED TO CONNECT TO DB");
  }
  return true;

  }






  

}


}