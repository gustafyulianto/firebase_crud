import 'package:flutter/material.dart';
import 'package:firebasecrud/model/sqluser_model.dart';
import 'package:firebasecrud/screen/login.dart';

class Register extends StatefulWidget {
  final UserLogin user;
  Register({this.user});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<UserLogin> listUser = List();
  //db_sqflite db = db_sqflite();

  TextEditingController User;
  TextEditingController Password;

  @override
  void initState() {
    User = TextEditingController(
        text: widget.user == null ? '' : widget.user.User);
    Password = TextEditingController(
        text: widget.user == null ? '' : widget.user.Password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.account_box),
        title: Center(child: Text("Form Register")),
        backgroundColor: Colors.blue,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(10),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: User,
                  decoration: new InputDecoration(
                      hintText: "Name",
                      labelText: "Full Name",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: Password,
                  decoration: new InputDecoration(
                      hintText: "Password",
                      labelText: "Password",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 10),
                SizedBox(height: 50),
                new Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new RaisedButton(
                          child: new Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.blue,
                          onPressed: () {
                            Cancel();
                            //send();
                          }),
                      SizedBox(width: 10),
                      new RaisedButton(
                          child: (widget.user == null)
                              ? new Text(
                                  "Add",
                                  style: TextStyle(color: Colors.white),
                                )
                              : Text(
                                  "Update",
                                  style:
                                      TextStyle(color: Colors.lightBlueAccent),
                                ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.blue,
                          onPressed: () {
                            //send();
                            //send();
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*Future<void> send() async {
    if (widget.user != null) {
      await db.updateUser(UserLogin.fromMap({
        'id': widget.user.id,
        'User': User.text,
        'Password': Password.text,
      }));
      Navigator.pop(context, 'Update');
    } else {
      await db.saveUser(UserLogin(
        User: User.text,
        Password: Password.text,
      ));
      Navigator.pop(context, 'Add');
    }
  }*/

  Future<void> Cancel() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
