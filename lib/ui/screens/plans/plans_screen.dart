import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/workout_model.dart';
import 'package:health_tracker/ui/screens/plans/widgets/workouts_card_widget.dart';
import 'package:health_tracker/shared/services/workouts_json.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  State<PlansScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<PlansScreen> {
  Future<List<Workouts>> workoutList = fetchWorkoutsJsonData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   title: const Text('Workouts'),
        //   centerTitle: true,
        // ),
        body: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  labelColor:
                      Theme.of(context).tabBarTheme.labelColor, //Colors.black,
                  indicator: DotIndicator(
                    color: Colors.red,
                    distanceFromCenter: 16,
                    radius: 3,
                    paintingStyle: PaintingStyle.fill,
                  ),
                  unselectedLabelColor:
                      Theme.of(context).tabBarTheme.unselectedLabelColor,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 60),

                  tabs: const [
                    Tab(
                      text: "WORKOUTS",
                    ),
                    Tab(
                      text: "Saved",
                    )
                  ],
                ),
                Expanded(
                    child: TabBarView(children: [
                  NewWorkout(newWorkoutsList: workoutList),
                  Container()
                ]))
              ],
            )));
  }
}
