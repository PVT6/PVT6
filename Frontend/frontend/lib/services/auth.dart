import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

// auth chnage user stream
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

// sign in with email & password

// register with email & password

Future registerWithEmailAndPassword(String email, String password) async { //Kan lägga till mer saker sen.
try {
  AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  FirebaseUser user = result.user;
  // https://group6-15.pvt.dsv.su.se/
  // var url = 'https://group6-15.pvt.dsv.su.se/user/new';
  var url = 'https://group6-15.pvt.dsv.su.se/user/new';

   var response = await http.post(Uri.parse(url),  body: {'uid': user.uid});

  print(response.body);
  if (response.statusCode == 200){

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
     if (response.body == "Found"){

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
    return await _auth.signOut();
  } catch(e){
    print(e.toString());
    return null;
  }
}

//More sign in methods. 


}