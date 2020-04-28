library frontend.user;

bool isLoggedIn = false;
String name = "";
String phone = "";
String email = "";
String uid = "";
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


