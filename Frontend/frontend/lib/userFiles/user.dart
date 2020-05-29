library frontend.user;
import 'package:latlong/latlong.dart';

bool isLoggedIn = false;
String name = "";
String phone = "";
String email = "";
String uid = "";
LatLng usersCurrentLocation = LatLng(59.303985, 18.097073);
void setName(String n) {
  name = n;
}
void setPhone(String n) {
  phone = n;
}
void setEmail(String n) {
  email = n;
}
void setLogin(bool n){
  isLoggedIn = n;
}
void setUid(String n){
  uid = n;
}
void setUserLocation(LatLng n){
  usersCurrentLocation = n;
}


