class UserLogin {
  int id;
  String User;
  String Password;

  UserLogin({this.id, this.User, this.Password});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['User'] = User;
    map['Password'] = Password;
    return map;
  }

  UserLogin.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.User = map['User'];
    this.Password = map['Password'];
  }
}
