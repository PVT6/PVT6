library frontend.user;

bool isLoggedIn = false;
String name;
String phone;
String email;
void setName(String n) {
  name = n;
}
void setPhone(String n) {
  phone = n;
}
void setEmail(String n) {
  email = n;
}
void setLogin(bool logged){
  isLoggedIn = logged;
}


