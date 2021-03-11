import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nightclazz_flutter/votes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nightclazz App',
      theme: ThemeData(primaryColor: Colors.red, primarySwatch: Colors.red),
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
  Rating selectedRating;
  int currentStep = 0;

  void _selectRating(Rating rating) {
    this.setState(() {
      this.selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('rate').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        final ratings =
            snapshot.data.docs.map((it) => Rating.fromDocument(it)).toList();
        return Stepper(
          type: StepperType.horizontal,
          currentStep: currentStep,
          steps: [
            Step(
                title: Text("Vote"),
                content: Votes(selectedRating, ratings, _selectRating),
                isActive: true),
            Step(
                title: Text("Résultats"),
                content: Results(ratings),
                isActive: currentStep == 1)
          ],
          controlsBuilder: _buildControls,
          onStepContinue: () {
            if (this.selectedRating != null && this.currentStep == 0) {
              final rating = FirebaseFirestore.instance
                  .collection('rate')
                  .doc(this.selectedRating.documentReference.id);
              rating.update({'votes': this.selectedRating.votes + 1});
              this.setState(() {
                this.selectedRating = null;
                this.currentStep = 1;
              });
            }
          },
          onStepCancel: () {
            if (this.currentStep == 1) {
              this.setState(() {
                this.currentStep = 0;
              });
            }
          },
        );
      },
    );
  }

  Widget _buildControls(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    final nextStepButton = MaterialButton(
      onPressed: this.selectedRating == null ? null : onStepContinue,
      child: Text("Voter"),
      color: Theme.of(context).primaryColor,
      disabledColor: Theme.of(context).disabledColor,
    );

    final previousStepButton = MaterialButton(
      onPressed: onStepCancel,
      child: Text("Retour"),
      color: Theme.of(context).primaryColor
    );

    return Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [ButtonBar(
      children: [
        currentStep == 0 ? nextStepButton : previousStepButton
      ],
    )]);
  }
}

class Results extends StatelessWidget {
  List<Rating> ratings;
  int totalVotes = 1;

  Results(this.ratings) {
    this.totalVotes =
        ratings.map((it) => it.votes).reduce((acc, votes) => acc + votes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          ratings.map((rating) => _buildRatingRow(rating, context)).toList(),
    );
  }

  Widget _buildRatingRow(Rating rating, BuildContext context) {
    List<Widget> icons = [];

    for (int i = 0; i < rating.value; i++) {
      icons.add(Icon(Icons.star));
    }

    for (int i = rating.value; i < 5; i++) {
      icons.add(Icon(Icons.star_border));
    }

    icons.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          width: 160,
          child: LinearProgressIndicator(
            value: rating.votes / this.totalVotes,
          ),
        )));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: icons,
      ),
    );
  }
}

class Rating {
  int value;
  int votes;
  DocumentReference documentReference;

  Rating.fromDocument(QueryDocumentSnapshot document) {
    this.votes = document.data()['votes'];
    this.documentReference = document.reference;
    this.value = int.parse(document.id);
  }
}
