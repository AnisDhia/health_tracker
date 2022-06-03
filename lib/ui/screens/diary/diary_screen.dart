import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_tracker/shared/styles/colors.dart';
import 'package:health_tracker/ui/screens/diary/heart/meassure_bpm_screen.dart';
import 'package:health_tracker/ui/screens/diary/heart/heart_stats_screen.dart';
import 'package:health_tracker/ui/screens/diary/nutrition/add_meal_screen.dart';
import 'package:health_tracker/ui/screens/diary/nutrition/calories_stats_screen.dart';
import 'package:health_tracker/ui/screens/diary/sleep/sleep_stats_screen.dart';
import 'package:health_tracker/ui/screens/diary/water/add_water_screen.dart';
import 'package:health_tracker/ui/screens/diary/water/water_stats_screen.dart';
import 'package:health_tracker/ui/screens/diary/weight/add_weight_screen.dart';
import 'package:health_tracker/ui/widgets/appbar_widget.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pedometer/pedometer.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  // DateTime _selectedDate = DateTime.now();
  // DateTime _focusedDate = DateTime.now();
  // CalendarFormat _calendarFormat = CalendarFormat.week;
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  // ? steps vars
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';
  int _todaySteps = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    log(event.toString());
    // DateTime s = event.timeStamp;
    setState(() {
      _todaySteps = event.steps;
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    log(event.toString());
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    log('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    log(_status);
  }

  void onStepCountError(error) {
    log('onStepCountError: $error');
    setState(() {
      // _todaySteps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: const NavDrawer(),
        appBar: CustomAppBar(title: "Diary"),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 450,
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? darkBlue
                          : Colors.transparent),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Good morning, ',
                            style: TextStyle(fontSize: 22),
                          ),
                          Text(
                            'Anis !',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            DateFormat('d MMMM, y').format(DateTime.now()),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      // ? STEPS CARD
                      Card(
                        // margin: const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
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
                                        flex: 2,
                                        child: Text('Walking record',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Today',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CircularPercentIndicator(
                                        // reverse: true,
                                        radius: 50,
                                        lineWidth: 7,
                                        animation: true,
                                        animateFromLastPercent: true,
                                        percent: _todaySteps < 12000
                                            ? _todaySteps / 12000
                                            : 1,
                                        center: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '$_todaySteps',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text('Steps',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color:
                                                        Colors.grey.shade500)),
                                          ],
                                        ),
                                        backgroundColor: Colors.grey.shade800,
                                        linearGradient:
                                            const LinearGradient(colors: [
                                          Color.fromARGB(255, 224, 139, 27),
                                          Colors.pink,
                                        ]),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                      ),
                                    ),
                                    Expanded(
                                      child: CircularPercentIndicator(
                                        // reverse: true,
                                        radius: 50,
                                        lineWidth: 7,
                                        animation: true,
                                        percent: 0.4,
                                        center: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              '102',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text('Min',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color:
                                                        Colors.grey.shade500)),
                                          ],
                                        ),
                                        backgroundColor: Colors.grey.shade800,
                                        linearGradient: const LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 224, 139, 27),
                                              Colors.pink
                                            ]),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      // ? DOUBLE COLLUMN
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // ? HEART CARD
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HeartStatsScreen(),
                                          ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: const [
                                              Expanded(
                                                  child: Text('Heart rate',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20))),
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
                                          SizedBox(
                                            height: 100,
                                            width: double.infinity,
                                            child: LineChart(LineChartData(
                                              gridData: FlGridData(show: false),
                                              titlesData:
                                                  FlTitlesData(show: false),
                                              borderData:
                                                  FlBorderData(show: false),
                                              minX: 0,
                                              maxX: 11,
                                              minY: 0,
                                              maxY: 6,
                                              lineBarsData: [
                                                LineChartBarData(
                                                    spots: const [
                                                      FlSpot(0, 3),
                                                      FlSpot(1, 3),
                                                      FlSpot(1.3, 3.5),
                                                      FlSpot(1.6, 2.8),
                                                      FlSpot(2.2, 4.5),
                                                      FlSpot(2.6, 1.5),
                                                      FlSpot(3, 3.3),
                                                      FlSpot(3.2, 3),
                                                      // second beat
                                                      FlSpot(4, 3),
                                                      FlSpot(4.3, 3.5),
                                                      FlSpot(4.6, 2.8),
                                                      FlSpot(5.2, 4.2),
                                                      FlSpot(5.6, 1.9),
                                                      FlSpot(6, 3.3),
                                                      FlSpot(6.2, 3),
                                                      // third beat
                                                      FlSpot(7, 3),
                                                      FlSpot(7.3, 3.5),
                                                      FlSpot(7.6, 2.8),
                                                      FlSpot(8.2, 4.7),
                                                      FlSpot(8.6, 2),
                                                      FlSpot(9, 3.3),
                                                      FlSpot(9.2, 3),
                                                      FlSpot(10, 3),
                                                    ],
                                                    color: const Color.fromARGB(
                                                        255, 220, 18, 18),
                                                    // gradient: const LinearGradient(
                                                    //   colors: [
                                                    //     Colors.red,
                                                    //     Colors.transparent
                                                    //   ],
                                                    //   begin: Alignment.centerLeft,
                                                    //   end: Alignment.centerRight,
                                                    // ),
                                                    barWidth: 2,
                                                    isStrokeCapRound: true,
                                                    dotData: FlDotData(
                                                      show: false,
                                                    ),
                                                    belowBarData: BarAreaData(
                                                        show: true,
                                                        gradient: RadialGradient(
                                                            radius: 1.6,
                                                            center: Alignment
                                                                .topCenter,
                                                            colors: [
                                                              const Color.fromARGB(
                                                                      255,
                                                                      220,
                                                                      18,
                                                                      18)
                                                                  .withOpacity(
                                                                      0.3),
                                                              // const Color(0xff02d39a)
                                                              //     .withOpacity(0.3),
                                                              Colors.transparent
                                                            ])
                                                        // LinearGradient(
                                                        //   colors: [
                                                        //     const Color(0xff23b6e6)
                                                        //         .withOpacity(0.3),
                                                        //     const Color(0xff02d39a)
                                                        //         .withOpacity(0.3),
                                                        //     Colors.transparent
                                                        //   ],
                                                        //   begin: Alignment.topCenter,
                                                        //   end: Alignment.bottomCenter,
                                                        //   transform: GradientTransform.,
                                                        // ),
                                                        ))
                                              ],
                                            )),
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                '107',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                'bpm',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                // ? CALORIES CARD
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const CaloriesStatsScreen(),
                                          ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: StreamBuilder<Object>(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection('diary')
                                              .doc(DateFormat('d-M-y')
                                                  .format(DateTime.now()))
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (!snapshot.hasData) {
                                              return const MyCircularIndicator();
                                            } else {
                                              late double calories;
                                              if (!snapshot.data!.exists) {
                                                calories = 0;
                                              } else {
                                                calories = snapshot.data!
                                                    .get('totalCalories');
                                              }
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: const [
                                                      Expanded(
                                                          child: Text(
                                                              'Calories',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20))),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Icon(
                                                          Icons
                                                              .local_fire_department,
                                                          color: Color.fromARGB(
                                                              255,
                                                              248,
                                                              105,
                                                              51),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  SizedBox(
                                                    height: 100,
                                                    width: 150,
                                                    child:
                                                        CircularPercentIndicator(
                                                      reverse: true,
                                                      radius: 45,
                                                      lineWidth: 7,
                                                      animation: true,
                                                      percent: calories < 2100
                                                          ? calories / 2100
                                                          : 1,
                                                      center: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            calories.toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 22),
                                                          ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text('Kcal',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500)),
                                                        ],
                                                      ),
                                                      backgroundColor:
                                                          Colors.grey.shade800,
                                                      linearGradient:
                                                          const LinearGradient(
                                                              colors: [
                                                            Color.fromARGB(255,
                                                                255, 209, 59),
                                                            Color.fromARGB(255,
                                                                248, 105, 51),
                                                          ],
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomLeft),
                                                      circularStrokeCap:
                                                          CircularStrokeCap
                                                              .round,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                // ? WATER CARD
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const WaterStatsScreen(),
                                          ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: StreamBuilder<Object>(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection('diary')
                                              .doc(DateFormat('d-M-y')
                                                  .format(DateTime.now()))
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (!snapshot.hasData) {
                                              return const MyCircularIndicator();
                                            } else {
                                              late dynamic water;
                                              if (!snapshot.data!.exists || !snapshot.data!.data()!.containsKey('water')) {
                                                water = 0;
                                              } else {
                                                water = snapshot.data!
                                                    .get('water') / 1000;
                                              }
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: const [
                                                      Expanded(
                                                          child: Text(
                                                        'Water',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      )),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Icon(
                                                          Icons.water_drop,
                                                          color: Color.fromARGB(
                                                              255,
                                                              84,
                                                              184,
                                                              252),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 100,
                                                    width: 150,
                                                    child:
                                                        LineChart(LineChartData(
                                                      gridData: FlGridData(
                                                          show: false),
                                                      titlesData: FlTitlesData(
                                                          show: false),
                                                      borderData: FlBorderData(
                                                          show: false),
                                                      minX: 0,
                                                      maxX: 11,
                                                      minY: 0,
                                                      maxY: 6,
                                                      lineBarsData: [
                                                        LineChartBarData(
                                                            spots: const [
                                                              FlSpot(0, 3),
                                                              FlSpot(2.6, 2),
                                                              FlSpot(4.9, 5),
                                                              FlSpot(6.8, 3.1),
                                                              FlSpot(8, 4),
                                                              FlSpot(9.5, 3),
                                                              FlSpot(11, 4),
                                                            ],
                                                            isCurved: true,
                                                            gradient:
                                                                const LinearGradient(
                                                              colors: [
                                                                Color(
                                                                    0xff23b6e6),
                                                                Color(
                                                                    0xff02d39a)
                                                              ],
                                                              begin: Alignment
                                                                  .centerLeft,
                                                              end: Alignment
                                                                  .centerRight,
                                                            ),
                                                            barWidth: 5,
                                                            isStrokeCapRound:
                                                                true,
                                                            dotData: FlDotData(
                                                              show: false,
                                                            ),
                                                            belowBarData: BarAreaData(
                                                                show: true,
                                                                gradient: RadialGradient(radius: 1.2, center: Alignment.topCenter, colors: [
                                                                  const Color(
                                                                          0xff23b6e6)
                                                                      .withOpacity(
                                                                          0.3),
                                                                  const Color(
                                                                          0xff02d39a)
                                                                      .withOpacity(
                                                                          0.3),
                                                                  Colors
                                                                      .transparent
                                                                ])
                                                                // LinearGradient(
                                                                //   colors: [
                                                                //     const Color(0xff23b6e6)
                                                                //         .withOpacity(0.3),
                                                                //     const Color(0xff02d39a)
                                                                //         .withOpacity(0.3),
                                                                //     Colors.transparent
                                                                //   ],
                                                                //   begin: Alignment.topCenter,
                                                                //   end: Alignment.bottomCenter,
                                                                //   transform: GradientTransform.,
                                                                // ),
                                                                ))
                                                      ],
                                                    )),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        water.toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 24),
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        'ltr',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .grey.shade600),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              );
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                                // ? SLEEP CARD
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SleepStatsScreen(),
                                          ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: const [
                                              Expanded(
                                                  child: Text(
                                                'Sleep',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(
                                                  CupertinoIcons
                                                      .moon_stars_fill,
                                                  color: Color.fromARGB(
                                                      255, 255, 200, 38),
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
                                                '8:30',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                'Hrs/day',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Colors.grey.shade600),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )

                  // Column(
                  //   children: [
                  //     TableCalendar(
                  //       firstDay: DateTime.utc(2010, 10, 16),
                  //       lastDay: DateTime.utc(2030, 3, 14),
                  //       focusedDay: _focusedDate,
                  //       calendarFormat: _calendarFormat,
                  //       calendarStyle: CalendarStyle(
                  //           selectedDecoration: const BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: Colors.red,
                  //           ),
                  //           todayDecoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: Colors.red.shade200,
                  //           )),
                  //       selectedDayPredicate: (day) {
                  //         return isSameDay(_selectedDate, day);
                  //       },
                  //       onDaySelected: (selectedDay, focusedDay) {
                  //         setState(() {
                  //           _selectedDate = selectedDay;
                  //           _focusedDate = focusedDay;
                  //         });
                  //       },
                  //       onFormatChanged: (format) {
                  //         setState(() {
                  //           _calendarFormat = format;
                  //         });
                  //       },
                  //       onPageChanged: (focusedDay) {
                  //         _focusedDate = focusedDay;
                  //       },
                  //     ),
                  //     const SizedBox(
                  //       height: 14,
                  //     ),
                  //     InkWell(
                  //         onDoubleTap: () {
                  //           // log('wow');
                  //         },
                  //         child: GoalCard(title: "Steps", value: _todaySteps, goal: 6000)),
                  //     const SizedBox(
                  //       height: 14,
                  //     ),
                  //     const GoalCard(
                  //       title: "Calories",
                  //       value: 1800,
                  //       goal: 2000,
                  //     ),
                  //     const SizedBox(
                  //       height: 14,
                  //     ),
                  //     const DiaryMealCard(
                  //       title: "Dinner",
                  //     ),
                  //     const SizedBox(
                  //       height: 14,
                  //     ),
                  //     ListView.builder(
                  //         physics: const ScrollPhysics(),
                  //         shrinkWrap: true,
                  //         itemCount: 15,
                  //         itemBuilder: (BuildContext context, int index) {
                  //           return ListTile(title: Text("item ${index + 1}"));
                  //         }),
                  //     const SizedBox(
                  //       height: 14,
                  //     ),
                  //   ],
                  // ),
                  ),
            ),
          ],
        ),
        floatingActionButton: FabCircularMenu(
          ringColor: Colors.black,
          fabOpenIcon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          fabCloseIcon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          ringWidth: 130,
          fabCloseColor: Colors.red,
          children: [
            RawMaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MeassureBPMScreen(),
                    ));
              },
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child:
                  const Icon(FontAwesomeIcons.heartPulse, color: Colors.white),
            ),
            RawMaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: const Text('Meals'),
                          children: [
                            SimpleDialogOption(
                                child: const Text('Breakfast'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddMealScreen(
                                                title: 'Breakfast',
                                              )));
                                }),
                            SimpleDialogOption(
                                child: const Text('Lunch'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddMealScreen(
                                                  title: 'Lunch')));
                                }),
                            SimpleDialogOption(
                                child: const Text('Dinner'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddMealScreen(
                                                  title: 'Dinner')));
                                }),
                            SimpleDialogOption(
                                child: const Text('Snacks'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddMealScreen(
                                                  title: 'Snacks')));
                                }),
                          ],
                        );
                      });
                  // TODO: add food
                },
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(Icons.restaurant, color: Colors.white)),
            RawMaterialButton(
              onPressed: () {},
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: const Icon(Icons.fitness_center, color: Colors.white),
            ),
            RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddWeightScreen(),
                      ));
                },
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(Icons.monitor_weight, color: Colors.white)),
            RawMaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddWaterScreen(),
                    ));
              },
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: const Icon(Icons.water_drop, color: Colors.white),
            ),
          ],
        )
        // const CircularFabWidget(),
        // SpeedDial(
        //     icon: Icons.add,
        //     foregroundColor: Colors.white,
        //     backgroundColor: Colors.red,
        //     shape: const CircleBorder(),
        //     // direction: ,
        //     overlayOpacity: 0.6,
        //     overlayColor: Colors.black,
        //     spaceBetweenChildren: 10,
        //     useRotationAnimation: true,
        //     children: [
        //       SpeedDialChild(
        //         child: const Icon(Icons.restaurant),
        //         label: 'Food',
        //         // backgroundColor: Colors.amberAccent,
        //         onTap: () {/* Do someting */},
        //       ),
        //       SpeedDialChild(
        //         child: const Icon(Icons.water_drop),
        //         label: 'Water',
        //         // backgroundColor: Colors.amberAccent,
        //         onTap: () {
        //           Navigator.push(context, MaterialPageRoute(builder: (context) => const AddWaterScreen(),));
        //         },
        //       ),
        //       SpeedDialChild(
        //         child: const Icon(Icons.monitor_weight_outlined),
        //         label: 'Weight',
        //         // backgroundColor: Colors.amberAccent,
        //         onTap: () {
        //           Navigator.push(context, MaterialPageRoute(builder: (context) => const AddWeightScreen(),));
        //         },
        //       ),
        //       SpeedDialChild(
        //         child: const Icon(Icons.fitness_center),
        //         label: 'Exercise',
        //         // backgroundColor: Colors.amberAccent,
        //         onTap: () {/* Do something */},
        //       ),
        //       SpeedDialChild(
        //         child: const Icon(FontAwesomeIcons.heartbeat),
        //         label: 'BPM',
        //         // backgroundColor: Colors.amberAccent,
        //         onTap: () {
        //           Navigator.push(context, MaterialPageRoute(builder: (context) => const MeassureBPMScreen(),));
        //         },
        //       ),
        //     ]),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    // throw UnimplementedError();

    double w = size.width;
    double h = size.height;

    final path = Path();

    path.moveTo(0, h);
    path.lineTo(0, 0); // 2. point
    path.quadraticBezierTo(w * 0.5, 200, w, 0);
    path.lineTo(w, h); // 5. point
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    // throw UnimplementedError();
    return true;
  }
}

// const double buttonSize = 60;

// class CircularFabWidget extends StatefulWidget {
//   const CircularFabWidget({Key? key}) : super(key: key);

//   @override
//   State<CircularFabWidget> createState() => _CircularFabWidgetState();
// }

// class _CircularFabWidgetState extends State<CircularFabWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   @override
//   void initState() {
//     super.initState();

//     controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 250));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Flow(
//       delegate: FlowMenuDelegate(controller: controller),
//       children: <IconData>[
//         Icons.water_drop,
//         Icons.restaurant,
//         Icons.fitness_center,
//         Icons.monitor_weight,
//         Icons.add,
//       ].map<Widget>(buildFAB).toList(),
//     );
//   }

//   Widget buildFAB(IconData icon) => SizedBox(
//         width: buttonSize,
//         height: buttonSize,
//         child: FloatingActionButton(
//           backgroundColor: Colors.red,
//           elevation: 0,
//           splashColor: Colors.black,
//           child: Icon(
//             icon,
//             color: Colors.white,
//             size: 35,
//           ),
//           onPressed: () {
//             if (controller.status == AnimationStatus.completed) {
//               controller.reverse();
//             } else {
//               controller.forward();
//             }
//           },
//         ),
//       );
// }

// class FlowMenuDelegate extends FlowDelegate {
//   final Animation<double> controller;

//   const FlowMenuDelegate({required this.controller})
//       : super(repaint: controller);

//   @override
//   void paintChildren(FlowPaintingContext context) {
//     final size = context.size;
//     final xStart = size.width - buttonSize;
//     final yStart = size.height - buttonSize;

//     final n = context.childCount;
//     for (int i = 0; i < n; i++) {
//       final isLastItem = i == context.childCount - 1,
//           setValue = (value) => isLastItem ? 0.0 : value,
//           radius = 180 * controller.value,
//           theta = i * math.pi * 0.5 / (n - 2),
//           x = xStart - setValue(radius * math.cos(theta)),
//           y = yStart - setValue(radius * math.sin(theta));

//       context.paintChild(
//         i,
//         transform: Matrix4.identity()
//           ..translate(x, y, 0)
//           ..translate(buttonSize / 2, buttonSize / 2)
//           ..rotateZ(
//               isLastItem ? 0.0 : 180 * (1 - controller.value) * math.pi / 180)
//           ..scale(isLastItem ? 1.0 : math.max(controller.value, 0.5))
//           ..translate(-buttonSize / 2, -buttonSize / 2),
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant FlowDelegate oldDelegate) {
//     return false;
//   }
// }
