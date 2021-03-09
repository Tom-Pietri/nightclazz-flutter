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
  int currentStep = 0;

  void _selectRating(int rating) {
    this.setState(() {
      this.selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
        type: StepperType.horizontal,
        currentStep: currentStep,
        steps: [
          Step(title: Text("Vote"), content: Votes(selectedRating, ratings, _selectRating)),
          Step(title: Text("Résultats"), content: Text("Résultats"))
        ],
        onStepContinue: () {
          if(this.selectedRating != null && this.currentStep == 0) {
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
  }
}
