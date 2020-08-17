import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebasecrud/model/kampus.dart';
import 'package:firebasecrud/screen/kampus_detail.dart';
import 'package:firebasecrud/drawer/MainDrawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebasecrud/screen/profile.dart';

class ListKampus extends StatefulWidget {
  @override
  _ListKampusState createState() => _ListKampusState();
}

class _ListKampusState extends State<ListKampus> {
  List<Kampus> _listKampus = List();
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  DatabaseReference _kampusRef;

  final _KampusNameController = TextEditingController();
  final _ProvinceController = TextEditingController();
  final _CityController = TextEditingController();
  final _FacultyController = TextEditingController();
  StreamSubscription<Event> _onKampusAddedSubscription;
  StreamSubscription<Event> _onKampusChangedSubscription;

  @override
  void initState() {
    _kampusRef = _database.reference().child("kampus");
    _onKampusAddedSubscription = _kampusRef.onChildAdded.listen(_onNewKampus);
    _onKampusChangedSubscription =
        _kampusRef.onChildAdded.listen(_onChangedKampus);
    super.initState();
  }

  @override
  void dispose() {
    _onKampusAddedSubscription.cancel();
    _onKampusChangedSubscription.cancel();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.accessibility),
        centerTitle: true,
        title: Text("KAMPUS FORM"),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        child: _showMahasiswaList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialogForm();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _showMahasiswaList() {
    if (_listKampus.length > 0) {
      return ListView.builder(
          itemCount: _listKampus.length,
          itemBuilder: (context, i) {
            Kampus kampus = _listKampus[i];
            return Dismissible(
              key: Key(kampus.key),
              background: Container(
                color: Colors.blue,
              ),
              onDismissed: (direction) async {
                _deleteKampus(kampus.key, i);
              },
              child: ListTile(
                title: Text(
                  kampus.KampusName,
                  style: TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.people,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new Profile(
                            id: i,
                            KampusName: kampus.KampusName,
                            Province: kampus.Province,
                            City: kampus.City,
                            Faculty: kampus.Faculty)));
                  },
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.details,
                    color: Colors.green,
                    size: 20.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new EditKampus(
                            id: kampus.key,
                            KampusName: kampus.KampusName,
                            Province: kampus.Province,
                            City: kampus.City,
                            Faculty: kampus.Faculty)));
                  },
                ),
              ),
            );
          });
    } else {
      return Center(
        child: Text("Data Empty"),
      );
    }
  }

  void _showDialogForm() {
    _KampusNameController.clear();
    _FacultyController.clear();
    _ProvinceController.clear();
    _CityController.clear();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _KampusNameController,
                          autofocus: true,
                          decoration:
                              InputDecoration(labelText: 'Add Kampus Name'),
                        ),
                        TextField(
                          controller: _ProvinceController,
                          autofocus: true,
                          decoration:
                              InputDecoration(labelText: 'Add Province'),
                        ),
                        TextField(
                          controller: _CityController,
                          autofocus: true,
                          decoration: InputDecoration(labelText: 'Add City'),
                        ),
                        TextField(
                          controller: _FacultyController,
                          autofocus: true,
                          decoration: InputDecoration(labelText: 'Add Faculty'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _addKampus(
                          _KampusNameController.text,
                          _ProvinceController.text,
                          _CityController.text,
                          _FacultyController.text);
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),
                  SizedBox(width: 50),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          );
        });
  }

  void _onNewKampus(Event event) {
    setState(() {
      _listKampus.add(Kampus.fromSnapshot(event.snapshot));
    });
  }

  void _onChangedKampus(Event event) {
    var oldEntry = _listKampus.singleWhere((kampus) {
      return kampus.key == event.snapshot.key;
    });
    setState(() {
      _listKampus[_listKampus.indexOf(oldEntry)] =
          Kampus.fromSnapshot(event.snapshot);
    });
  }

  Future<void> _addKampus(
      String KampusName, String Province, String City, String Faculty) async {
    if (KampusName.length > 0) {
      Kampus kampus = Kampus(
          KampusName: KampusName,
          Province: Province,
          City: City,
          Faculty: Faculty,
          completed: false);
      await _kampusRef.push().set(kampus.toJson());
    }
  }

  Future<void> _deleteKampus(String key, int i) async {
    await _kampusRef.child(key).remove();
    setState(() {
      _listKampus.removeAt(i);
    });
  }

  Future<void> _updateKampus(Kampus kampus) async {
    kampus.completed = !kampus.completed;
    await _kampusRef.push().set(kampus.toJson());
  }
}
