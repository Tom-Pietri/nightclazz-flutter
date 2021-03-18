import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nightclazz_flutter/results.dart';
import 'package:nightclazz_flutter/votes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nightclazz App",
      theme: ThemeData(
        primaryColor: Colors.red,
        primarySwatch: Colors.red
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello Nightclazz"),
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
  int selectedRating;
  int currentStep = 0;

  void selectRating(int rating) {
    this.setState(() {
      this.selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("rate").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<Rating> ratings =
              snapshot.data.docs.map((doc) => _mapDocToRating(doc)).toList();

          return Stepper(
            type: StepperType.horizontal,
            steps: [
              Step(
                title: Text("Vote"),
                content: Vote(
                    ratings: ratings.map((rating) => rating.value).toList(),
                    selectedRating: this.selectedRating,
                    selectRatingCallback: this.selectRating),
                isActive: true,
              ),
              Step(
                title: Text("Resultats"),
                content: Results(ratings: ratings),
                isActive: this.currentStep == 1,
              )
            ],
            currentStep: this.currentStep,
            onStepCancel: () {
              if (this.currentStep == 1) {
                this.setState(() {
                  this.currentStep--;
                });
              }
            },
            onStepContinue: () {
              if (this.currentStep == 0 && this.selectedRating != null) {
                _voter(selectedRating);
                this.setState(() {
                  this.selectedRating = null;
                  this.currentStep++;
                });
              }
            },
            controlsBuilder: (context, {onStepCancel, onStepContinue}) {
              var buttonNextStep = MaterialButton(
                child: Text("Voter"),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  disabledTextColor: Colors.white,
                  disabledColor: Theme.of(context).disabledColor,
                  onPressed: selectedRating != null ? onStepContinue : null,
              );
              var buttonPreviousStep = MaterialButton(
                child: Text("Retour"),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: onStepCancel,
              );

              return ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [currentStep == 0 ? buttonNextStep : buttonPreviousStep],
              );

            },
          );
        });
  }

  void _voter(int selectedRating) {
    var doc = FirebaseFirestore.instance
        .collection("rate")
        .doc(selectedRating.toString());
    doc.get().then((value) {
      doc.update({"votes": value.data()["votes"] + 1});
    });
  }
}

Rating _mapDocToRating(QueryDocumentSnapshot doc) {
  return Rating(value: int.parse(doc.id), votes: doc.data()["votes"]);
}

class Rating {
  int value;
  int votes;

  Rating({this.value, this.votes});
}
