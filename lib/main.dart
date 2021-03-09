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
        final ratings = snapshot.data.docs.map((it) => Rating.fromDocument(it)).toList();
        return Stepper(
          type: StepperType.horizontal,
          currentStep: currentStep,
          steps: [
            Step(title: Text("Vote"), content: Votes(selectedRating, ratings, _selectRating)),
            Step(title: Text("Résultats"), content: Text("Résultats"))
          ],
          onStepContinue: () {
            if(this.selectedRating != null && this.currentStep == 0) {
              final rating = FirebaseFirestore.instance.collection('rate').doc(this.selectedRating.documentReference.id);
              rating.update({'votes': this.selectedRating.votes + 1});
              this.setState(() {
                this.selectedRating = null;
                this.currentStep = 1;
              });
            }
          },
          onStepCancel: () {
            if(this.currentStep == 1) {
              this.setState(() {
                this.currentStep = 0;
              });
            }
          },
        );
      },
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