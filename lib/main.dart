import 'package:flutter/material.dart';
import 'package:nightclazz_flutter/votes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nightclazz App",
      theme: ThemeData(
        primaryColor: Colors.red
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Hello Nightclazz"),),
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
  List<int> ratings = [1, 2, 3, 4, 5];

  int selectedRating;
  int currentStep = 0;

  void selectRating(int rating) {
    this.setState(() {
      this.selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      steps: [
        Step(title: Text("Vote"), content:  Vote(
            ratings: this.ratings,
            selectedRating: this.selectedRating,
            selectRatingCallback : this.selectRating), isActive: true),
        Step(title: Text("Resultats"), content: Text("Resultats ici"), isActive: this.currentStep == 1)
      ],
      currentStep: this.currentStep,
      onStepCancel: () {
        if(this.currentStep == 1) {
          this.setState(() {
            this.currentStep--;
          });
        }
      },
      onStepContinue: () {
        if(this.currentStep == 0 && this.selectedRating != null) {
          this.setState(() {
            this.selectedRating = null;
            this.currentStep++;
          });
        }
      },
    );

  }
}

