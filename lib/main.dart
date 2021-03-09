import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nightclazz App',
      theme: ThemeData(
        primaryColor: Colors.red
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Nightclazz App"),
        ),
        body: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: ListTile(
          title: Row(children: [Icon(Icons.star), Icon(Icons.star), Icon(Icons.star), Icon(Icons.star), Icon(Icons.star)],),
        ),
      ),
    );
  }
}