import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebasecrud/model/mahasiswa.dart';
import 'package:firebasecrud/screen/data_detail.dart';
import 'package:firebasecrud/drawer/MainDrawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'view_detail.dart';

class ListMahasiswa extends StatefulWidget {
  @override
  _ListMahasiswaState createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  List<Mahasiswa> _listMahasiswa = List();
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  DatabaseReference _mahasiswaRef;

  final _NameController = TextEditingController();
  final _BirthPlaceController = TextEditingController();
  final _GenderController = TextEditingController();
  final _ReligionController = TextEditingController();
  StreamSubscription<Event> _onMahasiswaAddedSubscription;
  StreamSubscription<Event> _onMahasiswaChangedSubscription;

  @override
  void initState() {
    _mahasiswaRef = _database.reference().child("mahasiswa");
    _onMahasiswaAddedSubscription =
        _mahasiswaRef.onChildAdded.listen(_onNewMahasiswa);
    _onMahasiswaChangedSubscription =
        _mahasiswaRef.onChildAdded.listen(_onChangedMahasiswa);
    super.initState();
  }

  @override
  void dispose() {
    _onMahasiswaAddedSubscription.cancel();
    _onMahasiswaChangedSubscription.cancel();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.account_box),
        centerTitle: true,
        title: Text("STUDENT FORM"),
        backgroundColor: Colors.blue,
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
    if (_listMahasiswa.length > 0) {
      return ListView.builder(
          itemCount: _listMahasiswa.length,
          itemBuilder: (context, i) {
            Mahasiswa mahasiswa = _listMahasiswa[i];
            return Dismissible(
              key: Key(mahasiswa.key),
              background: Container(
                color: Colors.blue,
              ),
              onDismissed: (direction) async {
                _deleteMahasiswa(mahasiswa.key, i);
              },
              child: ListTile(
                title: Text(
                  mahasiswa.Name,
                  style: TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
                trailing: IconButton(
                  icon: (mahasiswa.completed)
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
                        builder: (BuildContext context) => new EditData(
                            id: mahasiswa.key,
                            Name: mahasiswa.Name,
                            BirthPlace: mahasiswa.BirthPlace,
                            Gender: mahasiswa.Gender,
                            Religion: mahasiswa.Religion)));
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
    _NameController.clear();
    _BirthPlaceController.clear();
    _GenderController.clear();
    _ReligionController.clear();
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
                          controller: _NameController,
                          autofocus: true,
                          decoration: InputDecoration(labelText: 'Add Name'),
                        ),
                        TextField(
                          controller: _BirthPlaceController,
                          autofocus: true,
                          decoration:
                              InputDecoration(labelText: 'Add BirthPlace'),
                        ),
                        TextField(
                          controller: _GenderController,
                          autofocus: true,
                          decoration: InputDecoration(labelText: 'Add Gender'),
                        ),
                        TextField(
                          controller: _ReligionController,
                          autofocus: true,
                          decoration:
                              InputDecoration(labelText: 'Add Religion'),
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
                      _addMahasiswa(
                          _NameController.text,
                          _BirthPlaceController.text,
                          _GenderController.text,
                          _ReligionController.text);
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

  void _onNewMahasiswa(Event event) {
    setState(() {
      _listMahasiswa.add(Mahasiswa.fromSnapshot(event.snapshot));
    });
  }

  void _onChangedMahasiswa(Event event) {
    var oldEntry = _listMahasiswa.singleWhere((mahasiswa) {
      return mahasiswa.key == event.snapshot.key;
    });
    setState(() {
      _listMahasiswa[_listMahasiswa.indexOf(oldEntry)] =
          Mahasiswa.fromSnapshot(event.snapshot);
    });
  }

  Future<void> _addMahasiswa(
      String Name, String BirthPlace, String Gender, String Religion) async {
    if (Name.length > 0) {
      Mahasiswa mahasiswa = Mahasiswa(
          Name: Name,
          BirthPlace: BirthPlace,
          Gender: Gender,
          Religion: Religion,
          completed: false);
      await _mahasiswaRef.push().set(mahasiswa.toJson());
    }
  }

  Future<void> _deleteMahasiswa(String key, int i) async {
    await _mahasiswaRef.child(key).remove();
    setState(() {
      _listMahasiswa.removeAt(i);
    });
  }

  Future<void> _updateMahasiswa(Mahasiswa mahasiswa) async {
    mahasiswa.completed = !mahasiswa.completed;
    await _mahasiswaRef.push().set(mahasiswa.toJson());
  }
}
