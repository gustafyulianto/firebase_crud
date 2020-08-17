import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebasecrud/model/kampus.dart';
import 'package:firebasecrud/screen/kampus_detail.dart';
import 'package:firebasecrud/drawer/MainDrawer.dart';
import 'package:firebase_database/firebase_database.dart';

class Profile extends StatefulWidget {
  Profile({this.KampusName, this.Province, this.City, this.Faculty, this.id});

  final String KampusName;
  final String Province;
  final String City;
  final String Faculty;
  final int id;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Kampus> _listKampus = List();
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  DatabaseReference _kampusRef;

  String KampusName;
  String Province;
  String City;
  String Faculty;
  int id;

  StreamSubscription<Event> _onKampusAddedSubscription;
  StreamSubscription<Event> _onKampusChangedSubscription;

  @override
  void initState() {
    KampusName = widget.KampusName;
    Province = widget.Province;
    City = widget.City;
    Faculty = widget.Faculty;
    id = widget.id;
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
    Kampus kampus = _listKampus[id];
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.blue])),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/b/b8/Nature.jpg",
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        kampus.KampusName,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Province",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      kampus.Province,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontStyle: FontStyle.normal,
                        fontSize: 28.0),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    kampus.Faculty,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 2.0,
                    ),
                  ),
                  Text(
                    kampus.City,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 2.0,
                    ),
                  ),
                  Text(
                    kampus.Province,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 300.00,
            child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                elevation: 0.0,
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.redAccent, Colors.pinkAccent]),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Contact me",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                )),
          ),
        ],
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
                trailing: IconButton(
                  icon: (kampus.completed)
                      ? Icon(
                          Icons.done_outline,
                          color: Colors.green,
                          size: 20.0,
                        )
                      : Icon(
                          Icons.done,
                          color: Colors.grey,
                          size: 20,
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
