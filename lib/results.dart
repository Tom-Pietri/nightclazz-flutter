import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'main.dart';

class Results extends StatelessWidget {
  List<Rating> ratings;

  Results({this.ratings});

  @override
  Widget build(BuildContext context) {

    int totalVotes = ratings.fold(0,
            (previousValue, rating) => previousValue + rating.votes);

    return Column(
      children: ratings
          .map((rating) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
                  children: [
                    _buildRatingTitle(rating.value),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: 180,
                        child: LinearProgressIndicator(
                          value: rating.votes / totalVotes,
                          minHeight: 10.0,
                        ),
                      ),
                    )
                  ],
                ),
          ))
          .toList(),
    );
  }

  Widget _buildRatingTitle(int rating) {
    List<Icon> icons = [];

    for (var i = 0; i < rating; i++) {
      icons.add(Icon(Icons.star));
    }

    for (var i = rating; i < ratings.length; i++) {
      icons.add(Icon(Icons.star_border));
    }

    return Row(
      children: icons,
    );
  }
}
