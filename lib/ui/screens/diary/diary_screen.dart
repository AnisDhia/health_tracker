import 'dart:async';
import 'dart:developer';
import 'dart:ui';

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
        // appBar: CustomAppBar(title: "Diary"),
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
                        children: [
                          Text(
                            DateTime.now().hour > 12 || DateTime.now().hour < 3
                                ? 'Good evening, '
                                : 'Good morning, ',
                            style: const TextStyle(fontSize: 22),
                          ),
                          const Text(
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
                                        child: Text('Activity',
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
                                        backgroundColor: Colors.grey.shade800
                                            .withOpacity(0.3),
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
                                        percent: _todaySteps * 0.04 / 1000,
                                        center: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${_todaySteps * 0.04}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                    Icons.local_fire_department,
                                                    size: 12),
                                                Text('kcal',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade500)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        backgroundColor: Colors.grey.shade800
                                            .withOpacity(0.3),
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
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Color.fromARGB(
                                                255, 255, 150, 128)),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text('Distance'),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              (_todaySteps * 0.0007)
                                                  .toStringAsFixed(2),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              'km',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                            FontAwesomeIcons.personWalking,
                                            color: Color.fromARGB(
                                                255, 249, 149, 76)),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text('Walking'),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: const [
                                            Text(
                                              '76',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '%',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                            FontAwesomeIcons.personRunning,
                                            color: Color.fromARGB(
                                                255, 247, 105, 132)),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text('Running'),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: const [
                                            Text(
                                              '24',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '%',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      // ? DOUBLE COLUMN
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
                                              if (!snapshot.data!.exists ||
                                                  !snapshot.data!
                                                      .data()!
                                                      .containsKey('water')) {
                                                water = 0;
                                              } else {
                                                water = snapshot.data!
                                                        .get('water') /
                                                    1000;
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
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                // ? NUTRITION CARD
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
                                              late double calories,
                                                  protein = 0,
                                                  carbs = 0,
                                                  fat = 0;
                                              if (!snapshot.data!.exists) {
                                                calories = 0;
                                              } else {
                                                calories = snapshot.data!
                                                    .get('totalCalories');
                                                protein = snapshot.data!
                                                    .get('totalProtein');
                                                carbs = snapshot.data!
                                                    .get('totalCarbs');
                                                fat = snapshot.data!
                                                    .get('totalFat');
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
                                                      backgroundColor: Colors
                                                          .grey.shade800
                                                          .withOpacity(0.3),
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
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          const Icon(
                                                              FontAwesomeIcons
                                                                  .bowlRice,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      250,
                                                                      109,
                                                                      77),
                                                              size: 16),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          const Text('Carbs'),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                carbs
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11),
                                                              ),
                                                              const Text(
                                                                'g',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        10),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          const Icon(FontAwesomeIcons.cheese,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      151,
                                                                      161,
                                                                      255),
                                                              size: 16),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          const Text('Fat'),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                fat.toString(),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11),
                                                              ),
                                                              const Text(
                                                                'g',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        10),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          const Icon(
                                                              FontAwesomeIcons
                                                                  .fish,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      247,
                                                                      105,
                                                                      132),
                                                              size: 16),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          const Text('Protein'),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                protein
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11),
                                                              ),
                                                              const Text(
                                                                'g',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        10),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
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
                  )),
            ),
          ],
        ),
        floatingActionButton: FabCircularMenu(
          onDisplayChange: (isOpen) {
            BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10));
          },
          ringColor: Theme.of(context).scaffoldBackgroundColor,
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
          fabOpenColor: Colors.grey.shade800,
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
              child: const Icon(
                FontAwesomeIcons.heartPulse,
              ),
            ),
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
              child: const Icon(
                FontAwesomeIcons.heartPulse,
              ),
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
                child: const Icon(
                  Icons.restaurant,
                )),
            RawMaterialButton(
              onPressed: () {},
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: const Icon(
                Icons.fitness_center,
              ),
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
                child: const Icon(
                  Icons.monitor_weight,
                )),
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
              child: const Icon(
                Icons.water_drop,
              ),
            ),
          ],
        ));
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
