import 'package:health_tracker/data/models/food_model.dart';

class Meal {
  final int id;
  final String title;
  final List<Food> foods;

  Meal({
    required this.id,
    required this.title,
    required this.foods,
  });

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      title: map['title'],
      foods: map['foods'], 
    );
  }

  void addFood(Food food) {
    foods.add(food);
  }
}