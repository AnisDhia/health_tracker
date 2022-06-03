import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart' as rootBundle;
import 'package:health_tracker/data/models/exercises/workout.dart';

Future<List<Workouts>> FetchWorkoutsJsonData() async {
  final data =
      await rootBundle.rootBundle.loadString('assets/json/workouts.json');
  final workoutsMap = json.decode(data) as Map<String, dynamic>;
  List<dynamic> workoutsList = workoutsMap["workouts"];

  return workoutsList.map((e) => Workouts.fromJson(e)).toList();
}
