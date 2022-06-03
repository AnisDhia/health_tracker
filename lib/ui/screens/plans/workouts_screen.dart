import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/exercises/workout.dart';
import 'package:health_tracker/ui/screens/plans/widgets/workouts_card_widget.dart';
import 'package:health_tracker/shared/services/workoutsFromJsonToModel.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
// import 'package:firebase_storage/firebase_storage.dart';

import 'package:health_tracker/ui/widgets/appbar_widget.dart';


class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({Key? key}): super(key: key);

  @override
  State<WorkoutsScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutsScreen> {
  Future<List<Workouts>> workoutList = FetchWorkoutsJsonData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Workouts'),
          centerTitle: true,
        ),
        body: Container(
          child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TabBar(
                    isScrollable: true,
                    labelColor: Theme.of(context)
                        .tabBarTheme
                        .labelColor, //Colors.black,
                    indicator: DotIndicator(
                      color: Colors.blue,
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
              )),
        ));
  }
}
