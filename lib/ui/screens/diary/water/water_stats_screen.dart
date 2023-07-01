import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
import 'package:intl/intl.dart';

class WaterStatsScreen extends StatefulWidget {
  const WaterStatsScreen({Key? key}) : super(key: key);

  @override
  State<WaterStatsScreen> createState() => _HeartDetailsScreenState();
}

class _HeartDetailsScreenState extends State<WaterStatsScreen> {
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
                  text: 'Week',
                ),
                Tab(
                  text: 'Month',
                ),
                Tab(
                  text: 'Year',
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('diary')
                      .doc(DateFormat('d-M-y').format(DateTime.now()))
                      .get(),
                  builder: (context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (!snapshot.hasData) {
                      return const MyCircularIndicator();
                    } else {
                      dynamic water;
                      if (!snapshot.data!.exists ||
                          !snapshot.data!.data()!.containsKey('water')) {
                        water = 0;
                      } else {
                        water = snapshot.data!.get('water');
                      }
                      return Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                water.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 36),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                'ml',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 139, 139, 139),
                                    fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                              height: 180,
                              width: double.infinity,
                              child: BarChart(
                                BarChartData(
                                    borderData: FlBorderData(show: false),
                                    barGroups: [
                                      BarChartGroupData(
                                          x: 1,
                                          barsSpace: 10,
                                          barRods: [
                                            BarChartRodData(
                                                width: 12,
                                                toY: 1800,
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      Colors.blue.shade800,
                                                      Colors.blue.shade200
                                                    ])),
                                          ]),
                                      BarChartGroupData(
                                          x: 2,
                                          barsSpace: 10,
                                          barRods: [
                                            BarChartRodData(
                                                width: 12,
                                                toY: 2150,
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      Colors.blue.shade800,
                                                      Colors.blue.shade200
                                                    ])),
                                          ]),
                                      BarChartGroupData(
                                          x: 3,
                                          barsSpace: 10,
                                          barRods: [
                                            BarChartRodData(
                                                width: 12,
                                                toY: 2800,
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      Colors.blue.shade800,
                                                      Colors.blue.shade200
                                                    ])),
                                          ]),
                                      BarChartGroupData(
                                          x: 4,
                                          barsSpace: 10,
                                          barRods: [
                                            BarChartRodData(
                                                width: 12,
                                                toY: 1500,
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      Colors.blue.shade800,
                                                      Colors.blue.shade200
                                                    ])),
                                          ]),
                                      BarChartGroupData(
                                          x: 5,
                                          barsSpace: 10,
                                          barRods: [
                                            BarChartRodData(
                                                width: 12,
                                                toY: 800,
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      Colors.blue.shade800,
                                                      Colors.blue.shade200
                                                    ])),
                                          ]),
                                      BarChartGroupData(
                                          x: 6,
                                          barsSpace: 10,
                                          barRods: [
                                            BarChartRodData(
                                                width: 12,
                                                toY: 2200,
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      Colors.blue.shade800,
                                                      Colors.blue.shade200
                                                    ])),
                                          ]),
                                      BarChartGroupData(
                                          x: 7,
                                          barsSpace: 10,
                                          barRods: [
                                            BarChartRodData(
                                                width: 12,
                                                toY: 2500,
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      Colors.blue.shade800,
                                                      Colors.blue.shade200
                                                    ])),
                                          ]),
                                    ],
                                    maxY: 4000,
                                    gridData: const FlGridData(show: false),
                                    titlesData: const FlTitlesData(
                                      show: true,
                                      leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                              getTitlesWidget: leftTitles,
                                              showTitles: true,
                                              reservedSize: 28,
                                              interval: 1)),
                                      bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: bottomTitles,
                                        reservedSize: 42,
                                      )),
                                      rightTitles: AxisTitles(),
                                      topTitles: AxisTitles(),
                                    )),
                              )),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          const Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Average Intake',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(
                                                  FontAwesomeIcons.glassWater,
                                                  color: Colors.blue,
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
                                                '11.5',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                'cups/day',
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
                              ),
                              Expanded(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          const Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Blood Oxygen',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(
                                                  Icons.water_drop,
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
                                                '95',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                '%',
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
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      );
                    }
                  }),
            ),
            const Text('Monthly data'),
            const Text('Yearly data'),
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
        'Water',
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

Widget bottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color.fromARGB(255, 191, 191, 191),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('Sun', style: style);
      break;
    case 2:
      text = const Text('Mon', style: style);
      break;
    case 3:
      text = const Text('Tue', style: style);
      break;
    case 4:
      text = const Text('Wed', style: style);
      break;
    case 5:
      text = const Text('Thu', style: style);
      break;
    case 6:
      text = const Text('Fri', style: style);
      break;
    case 7:
      text = const Text('Sat', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return Padding(padding: const EdgeInsets.only(top: 8.0), child: text);
}

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color.fromARGB(255, 191, 191, 191),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = '0';
      break;
    case 1000:
      text = '1';
      break;
    case 2000:
      text = '2';
      break;
    case 3000:
      text = '3';
      break;
    case 4000:
      text = '4';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
