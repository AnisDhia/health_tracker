import 'package:flutter/material.dart';
import 'package:health_tracker/model/recipe.api.dart';
import 'package:health_tracker/model/recipe.dart';
import 'package:health_tracker/widgets/drawer.dart';
import 'package:health_tracker/widgets/recipe_card.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({ Key? key }) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {

  late List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getRecipes();
  }

  Future<void> getRecipes() async{
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Recipes'), 
        centerTitle: true,
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index){
          return RecipeCard(
            title: _recipes[index].name, 
            cookTime: _recipes[index].totalTime, 
            rating: _recipes[index].rating.toString(), 
            thumbnailUrl: _recipes[index].images
            );
        },
      )
    );
  }
}