import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' as root_bundle;
import 'package:health_tracker/data/models/workout_model.dart';

Future<List<Workouts>> fetchWorkoutsJsonData() async {
  final data =
      await root_bundle.rootBundle.loadString('assets/json/workouts.json');
  final workoutsMap = json.decode(data) as Map<String, dynamic>;
  List<dynamic> workoutsList = workoutsMap["workouts"];

  return workoutsList.map((e) => Workouts.fromJson(e)).toList();
}
