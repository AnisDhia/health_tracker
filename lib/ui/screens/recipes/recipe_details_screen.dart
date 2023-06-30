import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/recipe_model.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class RecipeDetails extends StatelessWidget {
  final Recipe recipeModel;

  const RecipeDetails({Key? key, required this.recipeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        // appBar: AppBar(),
        body: SlidingUpPanel(
            color: Theme.of(context).scaffoldBackgroundColor,
            minHeight: size.height / 2,
            maxHeight: size.height / 1.2,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            parallaxEnabled: true,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: recipeModel.imageUrl,
                      child: Image(
                        height: (size.height / 2) + 50,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: NetworkImage(recipeModel.imageUrl),
                      ),
                    ),
                  ),
                  const Positioned(
                      top: 40,
                      right: 20,
                      child: Icon(
                        Icons
                            .bookmark_add_outlined, // TODO: bookmarked icon in details page
                        color: Colors.white,
                        size: 38,
                      )),
                  Positioned(
                      top: 40,
                      left: 20,
                      child: InkWell(
                        onTap: (() => Navigator.pop(context)),
                        child: const Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                          size: 38,
                        ),
                      ))
                ],
              ),
            ),
            panel: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    recipeModel.title,
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    recipeModel.author,
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons
                              .favorite_outline // TODO: sync details screen with database
                          // color:
                          ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("165"),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.timer_outlined,
                        // color:
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('${recipeModel.cookingTime}\''),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        color: Colors.black,
                        height: 30,
                        width: 2,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(recipeModel.servings.toString() +
                          (recipeModel.servings > 1 ? ' Servings' : 'Serving')),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  Expanded(
                      child: DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Theme.of(context).tabBarTheme.labelColor,
                          unselectedLabelColor: Theme.of(context)
                              .tabBarTheme
                              .unselectedLabelColor,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                          // labelPadding: const EdgeInsets.symmetric(horizontal: 32),
                          indicator: DotIndicator(
                            color: MyThemes.primary,
                            distanceFromCenter: 16,
                            radius: 3,
                            paintingStyle: PaintingStyle.fill,
                          ),
                          tabs: [
                            Tab(
                              text: "Ingredients".toUpperCase(),
                            ),
                            Tab(
                              text: "Preparation".toUpperCase(),
                            ),
                            Tab(
                              text: "Reviews".toUpperCase(),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        Expanded(
                            child: TabBarView(
                          children: [
                            Ingredients(
                              recipeModel: recipeModel,
                            ),
                            Preparation(
                              recipeModel: recipeModel,
                            ),
                            const Text('Reviews'),
                          ],
                        )),
                      ],
                    ),
                  ))
                ],
              ),
            )));
  }
}

class Ingredients extends StatelessWidget {
  final Recipe recipeModel;

  const Ingredients({Key? key, required this.recipeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: recipeModel.ingredients.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('⚫ ${recipeModel.ingredients[index]['original']}'),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.black.withOpacity(0.3),
              );
            },
          )
        ],
      ),
    );
  }
}

class Preparation extends StatelessWidget {
  final Recipe recipeModel;

  const Preparation({Key? key, required this.recipeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: recipeModel.preparation.isNotEmpty
                ? recipeModel.preparation[0]['steps'].length
                : 0,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                    '${index + 1} - ${recipeModel.preparation[0]['steps'][index]['step']}'),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.black.withOpacity(0.3),
              );
            },
          )
        ],
      ),
    );
  }
}
