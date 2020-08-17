import 'package:flutter/material.dart';
import 'package:firebasecrud/drawer/OwnDrawer.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OwnDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("STUDENT FORM",
            style: TextStyle(fontSize: 30, fontFamily: 'DancingScript')),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/main.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(),
      ),
    );
  }
}
