import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/exercise_model.dart';
import 'package:health_tracker/ui/screens/plans/widgets/exercise_details.dart';

class NewExercise extends StatelessWidget {
  final List<Exercise> newExercisesList;

  const NewExercise({
    Key? key,
    required this.newExercisesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      const SizedBox(
        height: 20,
      ),
      ListView.builder(
        padding: const EdgeInsets.all(8),
        physics: const ScrollPhysics(parent: null),
        shrinkWrap: true,
        itemCount: newExercisesList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseDetails(
                      exerciseDeatails: newExercisesList[index],
                    ),
                  )),
              child: ExerciseCard(
                exercise: newExercisesList[index],
              ),
            ),
          );
        },
      )
    ]));
  }
}

class ExerciseCard extends StatefulWidget {
  final Exercise exercise;
  // final bool bookmarked;

  const ExerciseCard({
    Key? key,
    required this.exercise,
    // required this.bookmarked,
  }) : super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  bool loved = false;

  @override
  Widget build(BuildContext context) {
    // final model.User user = Provider.of<UserProvider>(context).getUser;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 14, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.exercise.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Level: ${widget.exercise.level}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        'Equipment: ${widget.exercise.equipment}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )),
              // Spacer(),
              const Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // const Icon(Icons.timer_outlined),
                          // const SizedBox(
                          //   width: 4,
                          // ),
                          
                        ],
                      ),
                      // const Spacer(),
                      SizedBox(
                        height: 8,
                      ),
                      // InkWell(
                      //     onTap: () {
                      //       setState(() {
                      //         loved = !loved;
                      //       });
                      //     },
                      //     child: Icon(
                      //       loved ? Icons.favorite : Icons.favorite_border,
                      //       color: loved
                      //           ? Colors.red
                      //           : Theme.of(context).iconTheme.color,
                      //     )),
                    ],
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Hero(
                  tag: widget.exercise.imgs,
                  child: Image(
                    height: 150,
                    width: 350,
                    fit: BoxFit.fitWidth,
                    image: AssetImage(widget.exercise.imgs[0]),
                  ),
                ),
              ),
            ),
            const Positioned(
                top: 20,
                right: 40,
                child: InkWell(
                  // onTap: () => setState(() {
                  // TODO: implement bookmark functionallity
                  //   FireStoreService().bookmarkRecipe(
                  //       widget.recipe.id.toString(),
                  //       user.uid,
                  //       user.bookmarkedRecipes);
                  //   // saved = !saved;
                  // }),
                  child: Icon(
                    Icons.bookmark,
                    // user.bookmarkedRecipes.contains(widget.recipe.id) ? Icons.bookmark : Icons.bookmark_add_outlined,
                    color: Colors.white,
                    size: 38,
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
