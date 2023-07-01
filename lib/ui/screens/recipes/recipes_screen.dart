import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/recipe_model.dart';
import 'package:health_tracker/data/repositories/spoonacular_api.dart';
import 'package:health_tracker/ui/screens/recipes/recipe_details_screen.dart';
import 'package:health_tracker/ui/screens/recipes/widgets/recipe_card_widget.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  Future<List<Recipe>> recipeList = SpoonacularService.instance
      .getRandomRecipes(tags: "Pescetarian,keto,Whole30", number: 50);
  List<Future<List<Recipe>>> recipesByCategory = [
    SpoonacularService.instance.getRandomRecipes(number: 20, tags: 'keto'),
    SpoonacularService.instance
        .getRandomRecipes(number: 20, tags: 'pescetarian'),
    SpoonacularService.instance.getRandomRecipes(number: 20, tags: 'vegetarian')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                      text: 'Categories'.toUpperCase(),
                    ),
                    Tab(
                      text: 'Favourites'.toUpperCase(),
                    ),
                    Tab(
                      text: 'New Recipes'.toUpperCase(),
                    ),
                  ],
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
                  labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TabBarView(children: [
                      RecipeCategories(recipes: recipesByCategory),
                      const Center(child: Text("Favourites")),
                      NewRecipe(
                        newRecipesList: recipeList,
                      ),
                    ]),
                  ),
                )
              ],
            )));
  }
}

class RecipeCategories extends StatefulWidget {
  const RecipeCategories({Key? key, required this.recipes}) : super(key: key);

  final List recipes;
  @override
  State<RecipeCategories> createState() => _RecipeCategoriesState();
}

class _RecipeCategoriesState extends State<RecipeCategories> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Keto',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            HorizontalRecipes(category: "keto", recipesList: widget.recipes[0]),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Vegetarian',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            HorizontalRecipes(
                category: "vegetarian", recipesList: widget.recipes[1]),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Pescetarian',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            HorizontalRecipes(
                category: "pescetarian", recipesList: widget.recipes[2]),
          ],
        ),
      ),
    );
  }
}

class HorizontalRecipes extends StatelessWidget {
  const HorizontalRecipes(
      {Key? key, required this.category, required this.recipesList})
      : super(key: key);
  final Future<List<Recipe>> recipesList;
  final String category;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: FutureBuilder(
          future: recipesList,
          builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
            if (!snapshot.hasData) {
              return const MyCircularIndicator();
            } else {
              // List<Recipe> recipes = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  bool bookmarked = false;
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 8,
                    // margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetails(
                                recipeModel: snapshot.data![index],
                              ),
                            ));
                      },
                      child: SizedBox(
                        width: 150,
                        // height: 250,
                        child: Column(children: [
                          Image(
                              // width: 150,
                              // height: 100,
                              image:
                                  NetworkImage(snapshot.data![index].imageUrl)),
                          const SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    snapshot.data![index].title
                                    // .length > 30
                                    //     ? "${snapshot.data![index].title
                                    //             .substring(0, 30)}..."
                                    //     : snapshot.data![index].title
                                        ,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // const SizedBox(
                          //   height: 12,
                          // ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text("${snapshot.data![index].cookingTime} mins"),
                              IconButton(
                                  onPressed: () {
                                    bookmarked = !bookmarked;
                                    // setState(() {
                          
                                    // });
                                  },
                                  icon: Icon(bookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border))
                            ]),
                          )
                        ]),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
