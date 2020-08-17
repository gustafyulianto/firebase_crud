import 'package:flutter/material.dart';
import 'package:firebasecrud/model/sqluser_model.dart';
import 'package:firebasecrud/screen/register.dart';
import 'package:firebasecrud/drawer/MainDrawer.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<UserLogin> listUser = List();
  //db_sqflite db = db_sqflite();

  @override
  void initState() {
    //_getAllUser();
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          leading: new Icon(Icons.account_box),
          centerTitle: true,
          title: Text("STUDENT USER"),
          backgroundColor: Colors.blue,
        ),
        body: new ListView.builder(
            itemCount: listUser.length,
            itemBuilder: (context, i) {
              UserLogin user = listUser[i];
              return ListTile(
                onTap: () {
                  //edit
                  _openFormEdit(user);
                },
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  "${user.User}",
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                  ),
                ),
                subtitle: Text(user.Password),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    AlertDialog delete = AlertDialog(
                      title: Text('User Information'),
                      content: Container(
                        height: 100.0,
                        child: Column(
                          children: <Widget>[
                            Text(
                                'Are You Sure to Delete this data ${user.User}'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Yes'),
                          onPressed: () {
                            _deleteUser(user, i);
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                        ),
                        FlatButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                        ),
                      ],
                    );
                    showDialog(context: context, child: delete);
                  },
                ),
                leading: IconButton(
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => view_detail(user)));*/
                  },
                  icon: Icon(Icons.visibility),
                ),
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Main()),
                  );
                },
                child: Icon(Icons.navigate_before),
              ),
              FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {
                  _openFormCreate();
                },
                child: Icon(Icons.add),
              )
            ],
          ),
        ));
  }

  /*Future<void> _getAllUser() async {
    var list = await db.getAllUser();
    setState(() {
      listUser.clear();
      list.forEach((user) {
        listUser.add(UserLogin.fromMap(user));
      });
    });
  }*/

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Register(),
        ));

    if (result == 'Add') {
      //await _getAllUser();
    }
  }

  Future<void> _openFormEdit(UserLogin user) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Register(user: user),
        ));

    if (result == 'Update') {
      //await _getAllUser();
    }
  }

  Future<void> _deleteUser(UserLogin user, int Position) async {
    //await db.deleteUser(user.id);
    setState(() {
      listUser.removeAt(Position);
    });
  }
}
