import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/recipe_model.dart';
import 'package:health_tracker/data/repositories/firestore.dart';
import 'package:health_tracker/ui/screens/recipes/recipe_details_screen.dart';

class NewRecipe extends StatelessWidget {
  final Future<List<Recipe>> newRecipesList;

  const NewRecipe({Key? key, required this.newRecipesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        const SizedBox(
          height: 20,
        ),
        FutureBuilder(
            future: newRecipesList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                    child: CircularProgressIndicator(
                        // semanticsLabel: "Please wait...",
                        // semanticsValue: "Please wait",
                        ));
              } else {
                return ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetails(
                                recipeModel: snapshot.data[index],
                              ),
                            )),
                        child: RecipeCard(
                          recipe: snapshot.data[index],
                        ),
                      ),
                    );
                  },
                );
              }
            })
      ])),
    );
  }
}

class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  // final bool bookmarked;

  const RecipeCard({
    Key? key,
    required this.recipe,
    // required this.bookmarked,
  }) : super(key: key);

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool loved = false;

  @override
  Widget build(BuildContext context) {
    // final model.User user = Provider.of<UserProvider>(context).getUser;

    return Column(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Hero(
                  tag: widget.recipe.imageUrl,
                  child: Image(
                    height: 320,
                    width: 320,
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.recipe.imageUrl),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 20,
                right: 40,
                child: InkWell(
                    onTap: () {
                      FireStoreCrud().bookmarkRecipe(
                        widget.recipe.id.toString(),
                      );
                      // saved = !saved;
                    },
                    child: const Icon(
                      Icons.bookmark_add_outlined,
                      // color: Colors.white,
                      size: 38,
                    )
                    // StreamBuilder<Object>(
                    //     stream: FirebaseFirestore.instance
                    //         .collection('users')
                    //         .doc(FirebaseAuth.instance.currentUser!.uid)
                    //         .snapshots(),
                    //     builder: (context, AsyncSnapshot snapshot) {
                    //       if (snapshot.connectionState ==
                    //           ConnectionState.waiting) {
                    //         return const Icon(
                    //           Icons.bookmark_add_outlined,
                    //           color: Colors.white,
                    //           size: 38,
                    //         );
                    //       } else if (snapshot.data!
                    //           .data()['bookmarkedRecipes']
                    //           .contains(widget.recipe.id)) {
                    //         return const Icon(
                    //           Icons.bookmark,
                    //           color: Colors.white,
                    //           size: 38,
                    //         );
                    //       } else {
                    //         return const Icon(
                    //           Icons.bookmark_add_outlined,
                    //           color: Colors.white,
                    //           size: 38,
                    //         );
                    //       }
                    //     }),
                    ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.recipe.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.recipe.author,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )),
              // Spacer(),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(Icons.timer_outlined),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('${widget.recipe.cookingTime}\''),
                      const Spacer(),
                      InkWell(
                          onTap: () {
                            setState(() {
                              loved = !loved;
                            });
                          },
                          child: Icon(
                            loved ? Icons.favorite : Icons.favorite_border,
                            color: loved
                                ? Colors.red
                                : Theme.of(context).iconTheme.color,
                          )),
                    ],
                  )),
            ],
          ),
        )
      ],
    );
  }
}
