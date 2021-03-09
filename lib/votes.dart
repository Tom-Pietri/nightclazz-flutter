import 'package:flutter/material.dart';

import 'main.dart';

class Votes extends StatelessWidget {

  final List<Rating> ratings;
  final Rating selectedRating;
  void Function(Rating rating) selectRatingCallback;

  Votes(this.selectedRating, this.ratings, this.selectRatingCallback);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ratings.map((rating) => _buildRatingTile(context, rating)).toList(),
    );
  }

  Widget _buildRatingTile(BuildContext context, Rating rating) {
    List<Icon> icons = [];

    for(int i = 0 ; i < rating.value ; i++) {
      icons.add(Icon(Icons.star));
    }

    for(int i = rating.value ; i < 5 ; i++) {
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
          selected: selectedRating != null && selectedRating.value == rating.value,
          selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.9),
          onTap: () => this.selectRatingCallback(rating),
        ),
      ),
    );
  }
}