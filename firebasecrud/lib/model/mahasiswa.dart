import 'package:firebase_database/firebase_database.dart';

class Mahasiswa {
  final String key;
  int id;
  String Name;
  String BirthPlace;
  String Gender;
  String Religion;
  String RegEmail;
  String HpNumber;
  bool completed;

  Mahasiswa(
      {this.key,
      this.id,
      this.Name,
      this.BirthPlace,
      this.Gender,
      this.Religion,
      this.RegEmail,
      this.HpNumber,
      this.completed});

  Mahasiswa.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        id = snapshot.value['id'],
        Name = snapshot.value['Name'],
        BirthPlace = snapshot.value['BirthPlace'],
        Gender = snapshot.value['Gender'],
        Religion = snapshot.value['Religion'],
        RegEmail = snapshot.value['RegEmail'],
        completed = snapshot.value['completed'],
        HpNumber = snapshot.value['HpNumber'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'Name': Name,
        'BirthPlace': BirthPlace,
        'Gender': Gender,
        'Religion': Religion,
        'RegEmail': RegEmail,
        'HpNumber': HpNumber,
        'completed': completed
      };
}
