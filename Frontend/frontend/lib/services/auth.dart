import 'package:firebase_auth/firebase_auth.dart';

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