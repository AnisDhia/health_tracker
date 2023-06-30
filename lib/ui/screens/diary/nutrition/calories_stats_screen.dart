import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_tracker/data/repositories/firestore.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart' as pie;

class CaloriesStatsScreen extends StatefulWidget {
  const CaloriesStatsScreen({Key? key, required this.date}) : super(key: key);
  final DateTime date;

  @override
  State<CaloriesStatsScreen> createState() => _HeartDetailsScreenState();
}

class _HeartDetailsScreenState extends State<CaloriesStatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(children: [
          SizedBox(
            height: 36,
            child: TabBar(
              isScrollable: true,
              tabs: const [
                Tab(
                  text: 'Day',
                ),
                Tab(
                  text: 'Week',
                ),
                Tab(
                  text: 'Month',
                ),
              ],
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 255, 88, 128),
                    Color.fromARGB(255, 250, 124, 108),
                  ])),
              // indicatorColor: Colors.red,
              labelPadding: const EdgeInsets.symmetric(horizontal: 40),
            ),
          ),
          Expanded(
              child: TabBarView(children: [
            // ? DAY VIEW
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('diary')
                        .doc(DateFormat('d-M-y').format(widget.date))
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (!snapshot.hasData) {
                        return const MyCircularIndicator();
                      } else {
                        Map<String, dynamic> breakfast = {
                              'breakfastCalories': 0.0,
                              'breakfastProtein': 0.0,
                              'breakfastFat': 0.0,
                              'breakfastCarbs': 0.0,
                              'foods': [],
                            },
                            lunch = {
                              'lunchCalories': 0.0,
                              'lunchProtein': 0.0,
                              'lunchFat': 0.0,
                              'lunchCarbs': 0.0,
                              'foods': [],
                            },
                            dinner = {
                              'dinnerCalories': 0.0,
                              'dinnerProtein': 0.0,
                              'dinnerFat': 0.0,
                              'dinnerCarbs': 0.0,
                              'foods': [],
                            },
                            snacks = {
                              'snacksCalories': 0.0,
                              'snacksProtein': 0.0,
                              'snacksFat': 0.0,
                              'snacksCarbs': 0.0,
                              'foods': [],
                            };
                        double totalCalories = 0,
                            totalProtein = 0,
                            totalFat = 0,
                            totalCarbs = 0;
                        if (snapshot.data!.exists) {
                          if (snapshot.data!
                              .data()!
                              .containsKey('totalCalories')) {
                            totalCalories = snapshot.data!.get('totalCalories');
                          }
                          if (snapshot.data!
                              .data()!
                              .containsKey('totalProtein')) {
                            totalProtein = snapshot.data!.get('totalProtein');
                          }
                          if (snapshot.data!.data()!.containsKey('totalFat')) {
                            totalFat = snapshot.data!.get('totalFat');
                          }
                          if (snapshot.data!
                              .data()!
                              .containsKey('totalCarbs')) {
                            totalCarbs = snapshot.data!.get('totalCarbs');
                          }
                          if (snapshot.data!.data()!.containsKey('Breakfast')) {
                            breakfast = snapshot.data!.get('Breakfast');
                          }
                          if (snapshot.data!.data()!.containsKey('Lunch')) {
                            lunch = snapshot.data!.get('Lunch');
                          }
                          if (snapshot.data!.data()!.containsKey('Dinner')) {
                            dinner = snapshot.data!.get('Dinner');
                          }
                          if (snapshot.data!.data()!.containsKey('Snacks')) {
                            snacks = snapshot.data!.get('Snacks');
                          }
                        }
                        double percentCalories =
                            totalCarbs * 4 + totalProtein * 4 + totalFat * 9;
                        return Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '2000',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text('Goal',
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                const Text('-',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      totalCalories.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('Food',
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                const Text('=',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '${2000 - totalCalories}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                    const Text('Left',
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            LinearPercentIndicator(
                              percent: totalCalories >= 2000
                                  ? 1
                                  : totalCalories / 2000,
                              lineHeight: 1,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(totalCalories.toString()),
                                        const Text('kcal'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 90,
                                      width: 90,
                                      child: pie.PieChart(
                                        dataMap: {
                                          'Carbs': totalCarbs,
                                          'Fat': totalFat,
                                          'Protein': totalProtein,
                                        },
                                        chartType: pie.ChartType.ring,
                                        baseChartColor: Colors.grey.shade900
                                            .withOpacity(0.3),
                                        colorList: const [
                                          Color.fromARGB(255, 0, 210, 124),
                                          Color.fromARGB(255, 128, 71, 246),
                                          Color.fromARGB(255, 254, 164, 44)
                                        ],
                                        legendOptions: const pie.LegendOptions(
                                            showLegends: false),
                                        chartValuesOptions:
                                            const pie.ChartValuesOptions(
                                                showChartValues: false),
                                        ringStrokeWidth: 6,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${macroPercentage(totalCarbs, 1, percentCalories).round()}%',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 0, 210, 124)),
                                    ),
                                    Text('$totalCarbs g',
                                        style: const TextStyle(fontSize: 20)),
                                    const Text('Carbs'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                        '${macroPercentage(totalFat, 2, percentCalories).floor()}%',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 128, 71, 246))),
                                    Text('$totalFat g',
                                        style: const TextStyle(fontSize: 20)),
                                    const Text('Fat'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                        '${macroPercentage(totalProtein, 1, percentCalories).round()}%',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 254, 164, 44))),
                                    Text('$totalProtein g',
                                        style: const TextStyle(fontSize: 20)),
                                    const Text('Protein'),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 24,
                            ),

                            const SizedBox(
                              height: 24,
                            ),
                            // ? Breakfast
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text('Breakfast',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))),
                                      Text(
                                          breakfast['breakfastCalories']
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18))
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: breakfast['foods'].length,
                                      itemBuilder: ((context, index) {
                                        return ListTile(
                                          title: Text(breakfast['foods'][index]
                                                  ['name']
                                              .toString()),
                                          subtitle: Text(breakfast['foods']
                                                  [index]['calories']
                                              .toString()),
                                          trailing: IconButton(
                                              onPressed: () {
                                                FireStoreCrud()
                                                    .removeDiaryMealFood(
                                                  'Breakfast',
                                                  breakfast['foods'][index]
                                                      ['id'],
                                                  breakfast['foods'][index]
                                                      ['name'],
                                                  breakfast['foods'][index]
                                                      ['calories'],
                                                  breakfast['foods'][index]
                                                      ['carbs'],
                                                  breakfast['foods'][index]
                                                      ['fat'],
                                                  breakfast['foods'][index]
                                                      ['protein'],
                                                  breakfast['foods'][index]
                                                      ['source'],
                                                );
                                              },
                                              icon: const Icon(Icons.delete)),
                                        );
                                      })),
                                  NutritionRow(
                                      protein: breakfast['breakfastProtein']
                                          .toDouble(),
                                      carbs: breakfast['breakfastCarbs']
                                          .toDouble(),
                                      fat: breakfast['breakfastFat'].toDouble())
                                ]),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            // ? Lunch
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text('Lunch',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))),
                                      Text(lunch['lunchCalories'].toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18))
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: lunch['foods'].length,
                                      itemBuilder: ((context, index) {
                                        return ListTile(
                                          title: Text(lunch['foods'][index]
                                                  ['name']
                                              .toString()),
                                          subtitle: Text(lunch['foods'][index]
                                                  ['calories']
                                              .toString()),
                                          trailing: IconButton(
                                              onPressed: () {
                                                FireStoreCrud()
                                                    .removeDiaryMealFood(
                                                  'Lunch',
                                                  lunch['foods'][index]['id'],
                                                  lunch['foods'][index]['name'],
                                                  lunch['foods'][index]
                                                      ['calories'],
                                                  lunch['foods'][index]
                                                      ['carbs'],
                                                  lunch['foods'][index]['fat'],
                                                  lunch['foods'][index]
                                                      ['protein'],
                                                  lunch['foods'][index]
                                                      ['source'],
                                                );
                                              },
                                              icon: const Icon(Icons.delete)),
                                        );
                                      })),
                                  NutritionRow(
                                      protein: lunch['lunchProtein'].toDouble(),
                                      carbs: lunch['lunchCarbs'].toDouble(),
                                      fat: lunch['lunchFat'].toDouble())
                                ]),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            // ? Dinner
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text('Dinner',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))),
                                      Text(dinner['dinnerCalories'].toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18))
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: dinner['foods'].length,
                                      itemBuilder: ((context, index) {
                                        return ListTile(
                                          title: Text(dinner['foods'][index]
                                                  ['name']
                                              .toString()),
                                          subtitle: Text(dinner['foods'][index]
                                                  ['calories']
                                              .toString()),
                                          trailing: IconButton(
                                              onPressed: () {
                                                FireStoreCrud()
                                                    .removeDiaryMealFood(
                                                  'Dinner',
                                                  dinner['foods'][index]['id'],
                                                  dinner['foods'][index]
                                                      ['name'],
                                                  dinner['foods'][index]
                                                      ['calories'],
                                                  dinner['foods'][index]
                                                      ['carbs'],
                                                  dinner['foods'][index]['fat'],
                                                  dinner['foods'][index]
                                                      ['protein'],
                                                  dinner['foods'][index]
                                                      ['source'],
                                                );
                                              },
                                              icon: const Icon(Icons.delete)),
                                        );
                                      })),
                                  NutritionRow(
                                      protein:
                                          dinner['dinnerProtein'].toDouble(),
                                      carbs: dinner['dinnerCarbs'].toDouble(),
                                      fat: dinner['dinnerFat'].toDouble())
                                ]),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            // ? Snacks
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text('Snacks',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))),
                                      Text(snacks['snacksCalories'].toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18))
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snacks['foods'].length,
                                      itemBuilder: ((context, index) {
                                        return ListTile(
                                          title: Text(snacks['foods'][index]
                                                  ['name']
                                              .toString()),
                                          subtitle: Text(snacks['foods'][index]
                                                  ['calories']
                                              .toString()),
                                          trailing: IconButton(
                                              onPressed: () {
                                                FireStoreCrud()
                                                    .removeDiaryMealFood(
                                                  'Snacks',
                                                  snacks['foods'][index]['id'],
                                                  snacks['foods'][index]
                                                      ['name'],
                                                  snacks['foods'][index]
                                                      ['calories'],
                                                  snacks['foods'][index]
                                                      ['carbs'],
                                                  snacks['foods'][index]['fat'],
                                                  snacks['foods'][index]
                                                      ['protein'],
                                                  snacks['foods'][index]
                                                      ['source'],
                                                );
                                              },
                                              icon: const Icon(Icons.delete)),
                                        );
                                      })),
                                  NutritionRow(
                                      protein:
                                          snacks['snacksProtein'].toDouble(),
                                      carbs: snacks['snacksCarbs'].toDouble(),
                                      fat: snacks['snacksFat'].toDouble())
                                ]),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            //
                          ],
                        );
                      }
                    }),
              ),
            ),

            // ? WEEK VIEW
            const Text('Weekly data'),
            // ? MONTH VIEW
            const Text('Monthly data'),
          ]))
        ]),
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: const Text(
        'Calories',
        style: TextStyle(fontSize: 20),
      ),
      leading: TextButton(
          style: TextButton.styleFrom(
            shape: const CircleBorder(),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left,
            size: 34,
          )),
      actions: [
        TextButton(
            style: TextButton.styleFrom(
              shape: const CircleBorder(),
            ),
            onPressed: () {},
            child: const Icon(
              Icons.settings,
              size: 28,
            )),
        // const SizedBox(
        //   width: 14,
        // ),
      ],
    );
  }

  double macroPercentage(double value, int type, double percentCalories) {
    if (percentCalories == 0) {
      return 0;
    } else if (type == 1) {
      return (value * 4 / percentCalories) * 100;
    } else {
      return (value * 9 / percentCalories) * 100;
    }
  }
}

class NutritionRow extends StatelessWidget {
  const NutritionRow(
      {Key? key, required this.protein, required this.carbs, required this.fat})
      : super(key: key);
  final double protein, carbs, fat;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
        children: [
          const Icon(FontAwesomeIcons.bowlFood,
              color: Color.fromARGB(255, 0, 210, 124)),
          const SizedBox(
            height: 8,
          ),
          Text('$carbs g Carbs')
        ],
      ),
      Column(
        children: [
          const Icon(FontAwesomeIcons.cheese,
              color: Color.fromARGB(255, 128, 71, 246)),
          const SizedBox(
            height: 8,
          ),
          Text('$fat g Fats')
        ],
      ),
      Column(
        children: [
          const Icon(
            FontAwesomeIcons.fish,
            color: Color.fromARGB(255, 254, 164, 44),
          ),
          const SizedBox(
            height: 8,
          ),
          Text('$protein g Protein')
        ],
      ),
    ]);
  }
}
