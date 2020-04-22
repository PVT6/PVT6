import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

// auth chnage user stream
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

// sign in with email & password

// register with email & password

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