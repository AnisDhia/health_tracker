import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/exercise_model.dart';
import 'package:health_tracker/ui/screens/plans/widgets/exercise_card_widget.dart';

class WorkoutDetails extends StatelessWidget {
  // final List<Exercise> listOfExercises;
  final List<Exercise> newExercisesList;

  const WorkoutDetails({Key? key, required this.newExercisesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Exercises'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            NewExercise(newExercisesList: newExercisesList)
          ],
        ),
      ),
    );
  }
}
