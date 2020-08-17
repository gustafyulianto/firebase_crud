import 'package:flutter/material.dart';
import 'package:firebasecrud/model/mahasiswa.dart';
import 'package:firebasecrud/screen/data.dart';
import 'package:firebase_database/firebase_database.dart';

class EditData extends StatefulWidget {
  EditData({this.Name, this.BirthPlace, this.Gender, this.Religion, this.id});
  final String Name;
  final String BirthPlace;
  final String Gender;
  final String Religion;
  final String id;

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  DatabaseReference get _mahasiswaRef => _database.reference();
  List<Mahasiswa> listMahasiswa = List();

  TextEditingController Name;
  TextEditingController BirthPlace;
  TextEditingController Gender;
  TextEditingController Religion;
  TextEditingController id;
  @override
  void initState() {
    Name = TextEditingController(text: widget.Name == null ? '' : widget.Name);
    BirthPlace = TextEditingController(
        text: widget.BirthPlace == null ? '' : widget.BirthPlace);
    Religion = TextEditingController(
        text: widget.Religion == null ? '' : widget.Religion);
    Gender =
        TextEditingController(text: widget.Gender == null ? '' : widget.Gender);
    id = TextEditingController(text: widget.id == null ? '' : widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.account_box),
        title: Center(child: Text("Form Edit Student")),
        backgroundColor: Colors.blue,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(10),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: Name,
                  decoration: new InputDecoration(
                      hintText: "Name",
                      labelText: "Full Name",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: BirthPlace,
                  decoration: new InputDecoration(
                      hintText: "Place of Birth",
                      labelText: "Place of Birth",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: Religion,
                  decoration: new InputDecoration(
                      hintText: "Religion",
                      labelText: "Religion",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: Gender,
                  decoration: new InputDecoration(
                      hintText: "Gender",
                      labelText: "Gender",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 50),
                new Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new RaisedButton(
                          child: new Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.blue,
                          onPressed: () {
                            Update(Name.text, BirthPlace.text, Gender.text,
                                Religion.text, id.text);
                            //send();
                          }),
                      SizedBox(width: 10),
                      new RaisedButton(
                          child: new Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.blue,
                          onPressed: () {
                            //Cancel();
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

  Future<void> Update(String Name, String BirthPlace, String Gender,
      String Religion, String key) async {
    if (key == key) {
      Mahasiswa mahasiswa = Mahasiswa(
          Name: Name,
          BirthPlace: BirthPlace,
          Gender: Gender,
          Religion: Religion,
          completed: false);
      await _mahasiswaRef.child('mahasiswa').child(key).set(mahasiswa.toJson());
    }
  }
}
