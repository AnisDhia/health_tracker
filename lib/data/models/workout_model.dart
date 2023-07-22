import 'package:health_tracker/data/models/exercise_model.dart';

class Workouts {
  late final String name;
  late final String level;
  late final String imgUrl;
  late final int burnedCalories;
  late final int time;
  late final List<Exercise> exercises;

  Workouts(
      {required this.name,
      required this.level,
      required this.imgUrl,
      required this.burnedCalories,
      required this.time,
      required this.exercises});

  Workouts.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? 'unknown';
    level = json['level'] ?? 'unknown';
    time = json['time'] ?? 0;
    burnedCalories = json['burned calories'] ?? 0;
    imgUrl = json['imgUrl'] ?? 'unknown';
    if (json['exercises'] != null) {
      exercises = <Exercise>[];
      json['exercises'].forEach((v) {
        exercises.add(Exercise.fromJson(v));
      });
    }
  }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['name'] = name;
  //   data['level'] = level;
  //   data['time'] = time;
  //   data['burned calories'] = burnedCalories;
  //   data['imgUrl'] = imgUrl;
  //   data['exercises'] = exercises.map((v) => v.toJson()).toList();

  //   return data;
  // }
}
