import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SleepStatsScreen extends StatefulWidget {
  const SleepStatsScreen({Key? key}) : super(key: key);

  @override
  State<SleepStatsScreen> createState() => _HeartDetailsScreenState();
}

class _HeartDetailsScreenState extends State<SleepStatsScreen> {
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
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    const Row(
                      children: [
                        Text(
                          '7.5',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 36),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Hrs',
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
                                          toY: 7.5,
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.orange.shade700,
                                                Colors.amber,
                                              ])),
                                    ]),
                                BarChartGroupData(
                                    x: 2,
                                    barsSpace: 10,
                                    barRods: [
                                      BarChartRodData(
                                          width: 12,
                                          toY: 6,
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.orange.shade700,
                                                Colors.amber,
                                              ])),
                                    ]),
                                BarChartGroupData(
                                    x: 3,
                                    barsSpace: 10,
                                    barRods: [
                                      BarChartRodData(
                                          width: 12,
                                          toY: 8,
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.orange.shade700,
                                                Colors.amber,
                                              ])),
                                    ]),
                                BarChartGroupData(
                                    x: 4,
                                    barsSpace: 10,
                                    barRods: [
                                      BarChartRodData(
                                          width: 12,
                                          toY: 3,
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.orange.shade700,
                                                Colors.amber,
                                              ])),
                                    ]),
                                BarChartGroupData(
                                    x: 5,
                                    barsSpace: 10,
                                    barRods: [
                                      BarChartRodData(
                                          width: 12,
                                          toY: 9,
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.orange.shade700,
                                                Colors.amber,
                                              ])),
                                    ]),
                                BarChartGroupData(
                                    x: 6,
                                    barsSpace: 10,
                                    barRods: [
                                      BarChartRodData(
                                          width: 12,
                                          toY: 6.5,
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.orange.shade700,
                                                Colors.amber,
                                              ])),
                                    ]),
                                BarChartGroupData(
                                    x: 7,
                                    barsSpace: 10,
                                    barRods: [
                                      BarChartRodData(
                                          width: 12,
                                          toY: 8.5,
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.orange.shade700,
                                                Colors.amber,
                                              ])),
                                    ]),
                              ],
                              maxY: 12,
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
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          'Total sleep',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            CupertinoIcons.moon_stars_fill,
                                            color: Color.fromARGB(
                                                255, 255, 203, 51),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 32,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '8h 30m',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
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
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          'Deep sleep',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            FontAwesomeIcons.bed,
                                            color: Color.fromARGB(
                                                255, 152, 162, 255),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 32,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '3h 10m',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                    ),
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
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircularPercentIndicator(
                              startAngle: 240,
                              reverse: true,
                              radius: 45,
                              lineWidth: 7,
                              animation: true,
                              percent: 0.7,
                              center: const Text(
                                '72%',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: Colors.grey.shade800.withOpacity(0.3),
                              linearGradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 255, 209, 59),
                                    Color.fromARGB(255, 248, 105, 51),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomLeft),
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                            const Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Quality of sleep',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: Colors.red,
                                            size: 16,
                                          ),
                                          Text('0 - 50% Poor quality'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: Colors.orange,
                                            size: 16,
                                          ),
                                          Text('50 - 70% Avg. quality'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: Colors.green,
                                            size: 16,
                                          ),
                                          Text('Above 70% Good quality'),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
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
        'Sleep',
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
    case 2:
      text = '02';
      break;
    case 4:
      text = '04';
      break;
    case 6:
      text = '06';
      break;
    case 8:
      text = '08';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
