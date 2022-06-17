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
                  child: TabBarView(children: [
                    const RecipeCategories(),
                    const Center(child: Text("Favourites")),
                    NewRecipe(
                      newRecipesList: recipeList,
                    ),
                    // NewRecipe(),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Keto', style: TextStyle(fontSize: 24),),
        SizedBox(
          height: 4,
        ),
        HorizontalRecipes(category: "keto"),
        SizedBox(
          height: 8,
        ),
        Text('Vegetarian', style: TextStyle(fontSize: 24),),
        SizedBox(
          height: 4,
        ),
        HorizontalRecipes(category: "vegetarian"),
        SizedBox(
          height: 8,
        ),
        Text('Pescetarian', style: TextStyle(fontSize: 24),),
        SizedBox(
          height: 4,
        ),
        HorizontalRecipes(category: "pescetarian"),
      ],
        ),
      ),
    );
  }
}

class HorizontalRecipes extends StatelessWidget {
  const HorizontalRecipes({Key? key, required this.category}) : super(key: key);
  final String category;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: FutureBuilder(
          future: SpoonacularService.instance
              .getRandomRecipes(number: 15, tags: category),
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
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
