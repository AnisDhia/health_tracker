import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/workout_model.dart';
import 'package:health_tracker/ui/screens/plans/workouts_details.dart';

class NewWorkout extends StatelessWidget {
  final Future<List<Workouts>> newWorkoutsList;

  const NewWorkout({Key? key, required this.newWorkoutsList,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        const SizedBox(
          height: 20,
        ),
        FutureBuilder(
            future: newWorkoutsList,
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
                          horizontal: 0, vertical: 12),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkoutDetails(
                                newExercisesList: snapshot.data[index].exercises,
                              ),
                            )),
                        child: WorkoutCard(
                          workout: snapshot.data[index],
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

class WorkoutCard extends StatefulWidget {
  final Workouts workout;
  // final bool bookmarked;

  const WorkoutCard({
    Key? key,
    required this.workout,
    // required this.bookmarked,
  }) : super(key: key);

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
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
                  tag: widget.workout.imgUrl,
                  child: Image(
                    height: 220,
                    width: 350,
                    fit: BoxFit.fitWidth,
                    image: AssetImage(widget.workout.imgUrl),
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
        const SizedBox(
          height: 20,
        ),
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
                        widget.workout.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.workout.level,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )),
              // Spacer(),
              Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                          const Icon(Icons.timer_outlined),
                          const SizedBox(
                            width: 4,
                          ),
                          Text('${widget.workout.time}\'minutes'),
                       ],
                     ),
                      // const Spacer(),
                      const SizedBox(
                        height: 8,
                      ),
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
