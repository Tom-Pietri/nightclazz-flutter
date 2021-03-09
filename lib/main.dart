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
        body: Text("Hello nightclazz"),
      ),
    );
  }
}
