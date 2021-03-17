import 'package:flutter/material.dart';

class Vote extends StatelessWidget {
  List<int> ratings = [1, 2, 3, 4, 5];
  int selectedRating;
  Function(int rating) selectRatingCallback;

  Vote({this.ratings, this.selectedRating, this.selectRatingCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ratings.map((rating) => _buildVoteTile(context, rating)).toList(),
    );
  }
  Widget _buildVoteTile(BuildContext context, int rating) {
    List<Icon> icons = [];

    for(var i = 0 ; i <rating ; i++) {
      icons.add(Icon(Icons.star));
    }

    for(var i = rating ; i < ratings.length ; i++) {
      icons.add(Icon(Icons.star_border));
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6.0)
        ),
        child: ListTile(
          title: Row(
              children: icons
          ),
          selected: this.selectedRating == rating,
          selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.9),
          onTap: () => this.selectRatingCallback(rating),
        ),
      ),
    );
  }
}
