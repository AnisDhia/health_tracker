import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/recipe_model.dart';
import 'package:health_tracker/shared/services/api_service.dart';
import 'package:health_tracker/ui/widgets/drawer_widget.dart';
import 'package:health_tracker/ui/widgets/recipe_card_widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({ Key? key }) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  Future<List<Recipe>> recipeList = APIService.instance.getRandomRecipes(number: 6);

  @override
  Widget build(BuildContext context) {
    // final List<Recipe> recipesFromAPI = APIService.instance.getRandomRecipes(number: 3) as List<Recipe>;
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Recipes'), 
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(children: [
          const SizedBox(height: 40,),
          TabBar(
            isScrollable: true,
            tabs: [
            Tab(
              text: 'New Recipes'.toUpperCase(),
            ),
            Tab(
              text: 'Favourites'.toUpperCase(),
            ),
            Tab(
              text: 'Categories'.toUpperCase(),
            )
          ],
          labelColor: Theme.of(context).tabBarTheme.labelColor, //Colors.black,
          indicator: DotIndicator(
            color: Colors.red,
            distanceFromCenter: 16,
            radius: 3,
            paintingStyle: PaintingStyle.fill,
            ),
          unselectedLabelColor: Theme.of(context).tabBarTheme.unselectedLabelColor,
          labelPadding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          Expanded(
            child: TabBarView(
              children: [
                NewRecipe(newRecipesList: recipeList,),
                Container(
                  child: const Center(
                    child: Text("New")
                    ),
                ),
                // NewRecipe(),
                Container(
                  child: const Center(
                    child: Text("Categories")
                    ),
                ),
              ]
            ),
          )
        ],)
      )
    );
  }
}