import 'package:flutter/material.dart';
import 'package:nightclazz_flutter/votes.dart';

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

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ratings = [1, 2, 3, 4, 5];

  int selectedRating;

  void _selectRating(int rating) {
    this.setState(() {
      this.selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Votes(selectedRating, ratings, _selectRating);
  }
}
