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

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ratings = [1, 2, 3, 4, 5];

  int selectedRating;

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
          selected: selectedRating == rating,
          selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.9),
          onTap: () {
            this.setState(() {
              this.selectedRating = rating;
            });
          },
        ),
      ),
    );
  }
}