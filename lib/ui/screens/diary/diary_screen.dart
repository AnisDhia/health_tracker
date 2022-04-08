import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/user_model.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:health_tracker/ui/screens/diary/widgets/goal_card_widget.dart';
import 'package:health_tracker/ui/screens/diary/widgets/meal_card_widget.dart';
import 'package:health_tracker/ui/widgets/appbar_widget.dart';
import 'package:health_tracker/ui/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pedometer/pedometer.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';
  int _steps = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    log(event.toString());
    setState(() {
      _steps = event.steps;
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    log(event.toString());
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      // _steps = 'Step Count not available';
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
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 23, 28, 35)),
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
                    Card(
                      // margin: const EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
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
                                    percent: 0.7,
                                    center: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '720',
                                          style: TextStyle(
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
                                                color: Colors.grey.shade500)),
                                      ],
                                    ),
                                    backgroundColor: Colors.grey.shade800,
                                    linearGradient:
                                        const LinearGradient(colors: [
                                      Color.fromARGB(255, 224, 139, 27),
                                      Colors.pink,
                                    ]),
                                    circularStrokeCap: CircularStrokeCap.round,
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
                                                color: Colors.grey.shade500)),
                                      ],
                                    ),
                                    backgroundColor: Colors.grey.shade800,
                                    linearGradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 224, 139, 27),
                                          Colors.pink
                                        ]),
                                    circularStrokeCap: CircularStrokeCap.round,
                                  ),
                                ),
                              ],
                            )
                          ],
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
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              Icons.favorite_outlined,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 100,
                                        width: 150,
                                        child: LineChart(LineChartData(
                                          gridData: FlGridData(show: false),
                                          titlesData: FlTitlesData(show: false),
                                          borderData: FlBorderData(show: false),
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
                                                color: Colors.red,
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
                                                        center:
                                                            Alignment.topCenter,
                                                        colors: [
                                                          Colors.red
                                                              .withOpacity(0.3),
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
                                                color: Colors.grey.shade600),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: const [
                                          Expanded(
                                              child: Text('Calories',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20))),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              Icons.local_fire_department,
                                              color: Color.fromARGB(
                                                  255, 248, 105, 51),
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
                                        child: CircularPercentIndicator(
                                          reverse: true,
                                          radius: 45,
                                          lineWidth: 7,
                                          animation: true,
                                          percent: 0.7,
                                          center: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                '512',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text('Kcal',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors
                                                          .grey.shade500)),
                                            ],
                                          ),
                                          backgroundColor: Colors.grey.shade800,
                                          linearGradient: const LinearGradient(
                                              colors: [
                                                Color.fromARGB(
                                                    255, 255, 209, 59),
                                                Color.fromARGB(
                                                    255, 248, 105, 51),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomLeft),
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                        ),
                                      ),
                                    ],
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
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: const [
                                          Expanded(
                                              child: Text(
                                            'Water',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              Icons.water_drop,
                                              color: Color.fromARGB(
                                                  255, 84, 184, 252),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 100,
                                        width: 150,
                                        child: LineChart(LineChartData(
                                          gridData: FlGridData(show: false),
                                          titlesData: FlTitlesData(show: false),
                                          borderData: FlBorderData(show: false),
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
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xff23b6e6),
                                                    Color(0xff02d39a)
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                                barWidth: 5,
                                                isStrokeCapRound: true,
                                                dotData: FlDotData(
                                                  show: false,
                                                ),
                                                belowBarData: BarAreaData(
                                                    show: true,
                                                    gradient: RadialGradient(
                                                        radius: 1.2,
                                                        center:
                                                            Alignment.topCenter,
                                                        colors: [
                                                          const Color(
                                                                  0xff23b6e6)
                                                              .withOpacity(0.3),
                                                          const Color(
                                                                  0xff02d39a)
                                                              .withOpacity(0.3),
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
                                            '2.2',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'ltr',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade600),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              CupertinoIcons.moon_stars_fill,
                                              color: Color.fromARGB(
                                                  255, 255, 200, 38),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
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
                                                color: Colors.grey.shade600),
                                          ),
                                        ],
                                      )
                                    ],
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
                //         child: GoalCard(title: "Steps", value: _steps, goal: 6000)),
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
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   backgroundColor: Colors.red,
      //   foregroundColor: Colors.white,
      //   onPressed: () {
      //     // TODO: implement diary FAB functionality
      //   },
      // ),
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
