import 'package:flutter/material.dart';
import 'package:health_tracker/models/recipe_model.dart';

class RecipeDetails extends StatelessWidget {
  final RecipeModel recipeModel;
  
  const RecipeDetails({ 
    Key? key,
    required this.recipeModel
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}