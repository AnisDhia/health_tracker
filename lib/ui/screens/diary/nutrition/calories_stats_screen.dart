import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_tracker/data/repositories/firestore.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
import 'package:heart_bpm/chart.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:heart_bpm/heart_bpm.dart';

class CaloriesStatsScreen extends StatefulWidget {
  const CaloriesStatsScreen({Key? key}) : super(key: key);

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
                        .doc(DateFormat('d-M-y').format(DateTime.now()))
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (!snapshot.hasData) {
                        return const MyCircularIndicator();
                      } else {
                        double totalCalories =
                            snapshot.data!.get('totalCalories') ?? 0;
                        Map<String, dynamic> breakfast =
                            snapshot.data!.get('Breakfast');
                        Map<String, dynamic> lunch =
                            snapshot.data!.get('Lunch');
                        Map<String, dynamic> dinner =
                            snapshot.data!.get('Dinner');
                        Map<String, dynamic> snacks =
                            snapshot.data!.get('Snacks');
                        return Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                Text(
                                  totalCalories.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'kcal',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            // Expanded(
                            //     child: AspectRatio(
                            //   aspectRatio: 1,
                            //   child: PieChart(PieChartData(
                            //       centerSpaceRadius: 0,
                            //       sectionsSpace: 1,
                            //       startDegreeOffset: 180,
                            //       borderData: FlBorderData(show: false),
                            //       sections: [
                            //         PieChartSectionData(
                            //             radius: 80,
                            //             color: Colors.blue,
                            //             value: 200,
                            //             title: 'Breakfast'),
                            //         PieChartSectionData(
                            //             radius: 80,
                            //             color: Colors.red,
                            //             value: 400,
                            //             title: 'Lunch'),
                            //         PieChartSectionData(
                            //             radius: 80,
                            //             color: Colors.purple,
                            //             value: 40,
                            //             title: 'Dinner'),
                            //         PieChartSectionData(
                            //             radius: 80,
                            //             color: Colors.amber,
                            //             value: 100,
                            //             title: 'Snacks'),
                            //       ])),
                            // )),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: const [
                                                Expanded(
                                                    child: Text(
                                                  'Bpm range',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                )),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Icon(
                                                    FontAwesomeIcons.heartPulse,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 32,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  '60 - 100',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  'bpm',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: const [
                                                Expanded(
                                                    child: Text(
                                                  'Resting',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                )),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Icon(
                                                    FontAwesomeIcons.bed,
                                                    color: Color.fromARGB(
                                                        255, 152, 162, 255),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 32,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  '40',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  'bpm',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                                  'Breakfast',
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
                                                  'Breakfast',
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
                                                  'Breakfast',
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
                                ]),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'High today',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                )),
                            const SizedBox(
                              height: 14,
                            ),
                            LinearPercentIndicator(
                              // linearStrokeCap: LinearStrokeCap.round,
                              barRadius: const Radius.circular(26),
                              trailing: Row(
                                children: [
                                  const Text(
                                    '150',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'bpm',
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                              animation: true,
                              percent: 1,
                              lineHeight: 18,
                              linearGradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 250, 124, 108),
                                  Color.fromARGB(255, 255, 88, 128)
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Low today',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                )),
                            LinearPercentIndicator(
                              // linearStrokeCap: LinearStrokeCap.round,
                              barRadius: const Radius.circular(26),
                              trailing: Row(
                                children: [
                                  const Text(
                                    '68',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'bpm',
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.grey.shade800,
                              animation: true,
                              percent: 0.5,
                              lineHeight: 18,
                              progressColor: Colors.white,
                            ),
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
}
