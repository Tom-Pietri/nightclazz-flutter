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

  final ratings = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ratings.map((rating) => _buildRatingTile(context, rating)).toList(),
    );
  }

  Widget _buildRatingTile(BuildContext context, int rating) {
    List<Icon> icons = [];

    for(int i = 0 ; i < rating ; i++) {
      icons.add(Icon(Icons.star));
    }

    for(int i = rating ; i < 5 ; i++) {
      icons.add(Icon(Icons.star_border));
    }


    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: ListTile(
          title: Row(children: icons,),
        ),
      ),
    );
  }
}