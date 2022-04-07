import 'dart:async';
import 'dart:developer';

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
      body: SingleChildScrollView(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
                        const SizedBox(height: 24,),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: PieChart(PieChartData(
                                centerSpaceRadius: 30,
                                sectionsSpace: 0,
                                borderData: FlBorderData(show: false),
                                sections: [
                                  PieChartSectionData(
                                    // title: "Steps",
                                    value: 60,
                                    color: MyThemes.primary,
                                  ),
                                  PieChartSectionData(
                                    // title: "Steps",
                                    value: 40,
                                    color: Colors.white,
                                  )
                                ]
                              )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

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
