import 'package:flutter/material.dart';
import 'package:health_tracker/model/recipe_model.dart';

class NewRecipe extends StatelessWidget {
  final String title;
  final String rating;
  final String cookTime;
  final String thumbnailUrl;

  const NewRecipe({
    Key? key,
    required this.title,
    required this.cookTime,
    required this.rating,
    required this.thumbnailUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: RecipeModel.demoRecipe.length,
              itemBuilder: (BuildContext context, int index) {
                return RecipeCard(recipeModel: RecipeModel.demoRecipe[index]);
              },
            )
          ]
        )
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final RecipeModel recipeModel;

  const RecipeCard({ 
    Key? key,
    required this.recipeModel, 
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            
          ],
        ),
      ],
    );
  }
}