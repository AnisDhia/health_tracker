import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/recipe_model.dart';
import 'package:health_tracker/data/repositories/spoonacular_api.dart';
import 'package:health_tracker/ui/screens/recipes/widgets/recipe_card_widget.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  Future<List<Recipe>> recipeList =
      SpoonacularService.instance.getRandomRecipes(tags: "keto", number: 15);
  // ScrollController _scrollController = new ScrollController();

  // @override
  // void dispose() {
  //   _scrollController.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final List<Recipe> recipesFromAPI = APIService.instance.getRandomRecipes(number: 3) as List<Recipe>;
    return Scaffold(
        // drawer: const NavDrawer(),
        // appBar: AppBar(
        //   elevation: 0,
        //   title: const Text('Recipes'),
        //   centerTitle: true,
        // ),
        body: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Column(
              children: [
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
                  child: TabBarView(children: [
                    NewRecipe(
                      newRecipesList: recipeList,
                    ),
                    const Center(child: Text("New")),
                    // NewRecipe(),
                    const RecipeCategories(),
                  ]),
                )
              ],
            )));
  }
}

class RecipeCategories extends StatefulWidget {
  const RecipeCategories({
    Key? key,
  }) : super(key: key);

  @override
  State<RecipeCategories> createState() => _RecipeCategoriesState();
}

class _RecipeCategoriesState extends State<RecipeCategories> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Expanded(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 230,
              child: FutureBuilder(
                  future: SpoonacularService.instance
                      .getRandomRecipes(number: 15, tags: "keto"),
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
                            elevation: 10,
                            // margin: const EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: SizedBox(
                              width: 150,
                              // height: 250,
                              child: Column(children: [
                                Image(
                                    // width: 150,
                                    // height: 100,
                                    image: NetworkImage(
                                        snapshot.data![index].imageUrl)),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        snapshot.data![index].title,
                                        // softWrap: false,
                                        // overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(children: [
                                  IconButton(
                                      onPressed: () {
                                        bookmarked = !bookmarked;
                                        // setState(() {
                                          
                                        // });
                                      },
                                      icon: Icon(bookmarked
                                          ? Icons.bookmark
                                          : Icons.bookmark_border))
                                ])
                              ]),
                            ),
                          );
                        },
                      );
                    }
                  }),
            )
          ],
        ),
      )),
    );
  }
}
