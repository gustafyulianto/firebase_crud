import 'package:firebase_database/firebase_database.dart';

class Kampus {
  final String key;
  String KampusName;
  String Province;
  String City;
  String Faculty;
  bool completed;

  Kampus(
      {this.key,
      this.KampusName,
      this.Province,
      this.Faculty,
      this.City,
      this.completed});

  Kampus.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        KampusName = snapshot.value['KampusName'],
        Province = snapshot.value['Province'],
        Faculty = snapshot.value['Faculty'],
        City = snapshot.value['City'],
        completed = snapshot.value['completed'];

  Map<String, dynamic> toJson() => {
        'KampusName': KampusName,
        'Province': Province,
        'Faculty': Faculty,
        'City': City,
        'completed': completed
      };
}
