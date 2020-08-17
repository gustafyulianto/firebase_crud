import 'package:flutter/material.dart';
import 'package:firebasecrud/model/mahasiswa.dart';
import 'package:firebasecrud/model/kampus.dart';
import 'package:firebase_database/firebase_database.dart';

class EditKampus extends StatefulWidget {
  EditKampus(
      {this.KampusName, this.Province, this.City, this.Faculty, this.id});
  final String KampusName;
  final String Province;
  final String City;
  final String Faculty;
  final String id;

  @override
  _EditKampusState createState() => _EditKampusState();
}

class _EditKampusState extends State<EditKampus> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  DatabaseReference get _kampusRef => _database.reference();
  List<Kampus> _listKampus = List();

  TextEditingController KampusName;
  TextEditingController Province;
  TextEditingController City;
  TextEditingController Faculty;
  TextEditingController id;
  @override
  void initState() {
    KampusName = TextEditingController(
        text: widget.KampusName == null ? '' : widget.KampusName);
    Province = TextEditingController(
        text: widget.Province == null ? '' : widget.Province);
    City = TextEditingController(text: widget.City == null ? '' : widget.City);
    Faculty = TextEditingController(
        text: widget.Faculty == null ? '' : widget.Faculty);
    id = TextEditingController(text: widget.id == null ? '' : widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.accessibility),
        title: Center(child: Text("Form Edit Kampus")),
        backgroundColor: Colors.blue,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(10),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: KampusName,
                  decoration: new InputDecoration(
                      hintText: "Kampus Name",
                      labelText: "Kampus Name",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: Province,
                  decoration: new InputDecoration(
                      hintText: "Province",
                      labelText: "Province",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: City,
                  decoration: new InputDecoration(
                      hintText: "City",
                      labelText: "City",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: Faculty,
                  decoration: new InputDecoration(
                      hintText: "Faculty",
                      labelText: "Faculty",
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
                            Update(KampusName.text, Province.text, City.text,
                                Faculty.text, id.text);
                            Navigator.pop(context);
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
                            Navigator.pop(context);
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

  Future<void> Update(String KampusName, String Province, String City,
      String Faculty, String key) async {
    if (key == key) {
      Kampus kampus = Kampus(
          KampusName: KampusName,
          Province: Province,
          City: City,
          Faculty: Faculty,
          completed: false);
      await _kampusRef.child('kampus').child(key).set(kampus.toJson());
    }
  }
}
