import 'package:flutter/material.dart';
import 'package:firebasecrud/model/mahasiswa.dart';

class view_detail extends StatelessWidget {
  final Mahasiswa mahasiswa;
  view_detail(this.mahasiswa);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DATA VIEW"),
        ),
        body: Center(
          child: new Column(
            children: <Widget>[
              new Text('Name: ${mahasiswa.Name}'),
              new Text("Birth Place: ${mahasiswa.BirthPlace}"),
              new Text("Gender: ${mahasiswa.Gender}"),
              new Text("Religion: ${mahasiswa.Religion}"),
              new Text("Registration Email: ${mahasiswa.RegEmail}"),
              new Text("HP Number: ${mahasiswa.HpNumber}"),
              new RaisedButton(
                  child: new Text("Back"),
                  onPressed: () => Navigator.pop(context))
            ],
          ),
        ));
  }
}
