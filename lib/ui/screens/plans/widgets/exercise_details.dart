import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:health_tracker/data/models/exercise_model.dart';
import 'package:health_tracker/shared/styles/themes.dart';

class ExerciseDetails extends StatelessWidget {
  final Exercise exerciseDeatails;

  const ExerciseDetails({Key? key, required this.exerciseDeatails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(),
        body: SlidingUpPanel(
            color: Theme.of(context).scaffoldBackgroundColor,
            minHeight: size.height / 1.5,
            maxHeight: size.height / 1.2,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            parallaxEnabled: true,
            body: SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: Hero(
                    tag: exerciseDeatails.imgs[0],
                    child: CarouselSlider.builder(
                        itemCount: exerciseDeatails.imgs.length,
                        itemBuilder: (context, index, realIndex) {
                          final urlImage = exerciseDeatails.imgs[index];
                          return buildImage(urlImage, index);
                        },
                        options: CarouselOptions(
                            height: 210,
                            autoPlay: true,
                            autoPlayAnimationDuration:
                                const Duration(seconds: 2),
                                autoPlayInterval: const Duration(seconds: 3)
                                ))),
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
                    exerciseDeatails.name,
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    exerciseDeatails.category,
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      // const Icon(Icons
                      //         .favorite_outline // TODO: sync details screen with database
                      //     // color:
                      //     ),
                      // const SizedBox(
                      //   width: 5,
                      // ),
                      Text('Level: ${exerciseDeatails.level.toUpperCase()},'),
                      // const SizedBox(
                      //   width: 60,
                      // ),
                      //  Container(
                      //   color: Colors.black,
                      //   height: 30,
                      //   width: 2,
                      // ),
                      // const Icon(
                      //   Icons.timer_outlined,
                      //   // color:
                      // ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('Equipment: ${exerciseDeatails.equipment.toUpperCase()}'),
                      const SizedBox(
                        width: 20,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      // Text(exerciseDeatails..toString() +
                      //     (exerciseDeatails.servings > 1 ? ' Servings' : 'Serving')),
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
                    length: 2,
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
                              text: "Instructions".toUpperCase(),
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
                            Instructions(
                              exerciseDeatails: exerciseDeatails,
                            ),
                            // Preparation(
                            //   exerciseDeatails: exerciseDeatails,
                            // ),
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

  Widget buildImage(String urlImage, int index) => Container(
        // margin: const EdgeInsets.symmetric(horizontal: 8),
        color: Colors.grey,
        child: Image.asset(
          exerciseDeatails.imgs[index],
          fit: BoxFit.fitWidth,
        ),
      );
}

class Instructions extends StatelessWidget {
  final Exercise exerciseDeatails;

  const Instructions({Key? key, required this.exerciseDeatails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: exerciseDeatails.instructions.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('⚫ ${exerciseDeatails.instructions[index]}'),
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

// class Preparation extends StatelessWidget {
//   final Recipe exerciseDeatails;

//   const Preparation({Key? key, required this.exerciseDeatails}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           ListView.separated(
//             physics: const ScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: exerciseDeatails.preparation.isNotEmpty ? exerciseDeatails.preparation[0]['steps'].length : 0,
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: Text(
//                     (index+1).toString() + ' - ' + exerciseDeatails.preparation[0]['steps'][index]['step']),
//               );
//             },
//             separatorBuilder: (BuildContext context, int index) {
//               return Divider(
//                 color: Colors.black.withOpacity(0.3),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
