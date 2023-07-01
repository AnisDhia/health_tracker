import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HeartStatsScreen extends StatefulWidget {
  const HeartStatsScreen({Key? key}) : super(key: key);

  @override
  State<HeartStatsScreen> createState() => _HeartDetailsScreenState();
}

class _HeartDetailsScreenState extends State<HeartStatsScreen> {
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Text(
                        '102',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'bpm',
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
                  SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: LineChart(LineChartData(
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: const FlTitlesData(
                        show: true,
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 1,
                            getTitlesWidget: bottomTitleWidgets,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: leftTitleWidgets,
                            reservedSize: 42,
                          ),
                        ),
                      ),
                      // borderData: FlBorderData(
                      //     show: true,
                      //     border: Border.all(
                      //         color: const Color(0xff37434d), width: 1)),
                      minX: 2,
                      maxX: 24,
                      minY: 0,
                      maxY: 160,
                      lineBarsData: [
                        LineChartBarData(
                            spots: const [
                              FlSpot(2, 0),
                              // FlSpot(5, 60),
                              FlSpot(6, 70),
                              FlSpot(10, 65),
                              FlSpot(14, 140),
                              FlSpot(17, 75),
                              FlSpot(22, 120),
                              FlSpot(24, 120),
                            ],
                            isCurved: true,
                            // color: const Color.fromARGB(255, 220, 18, 18),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.red,
                                Color.fromARGB(255, 255, 44, 94),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            barWidth: 4,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(
                              show: false,
                            ),
                            belowBarData: BarAreaData(
                                show: true,
                                gradient: RadialGradient(
                                    radius: 1.6,
                                    center: Alignment.topCenter,
                                    colors: [
                                      const Color.fromARGB(255, 220, 18, 18)
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
                                        'Bpm range',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )),
                                      Align(
                                        alignment: Alignment.centerRight,
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
                                        'Resting',
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
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        '40',
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'High today',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
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
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'bpm',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.grey.shade800.withOpacity(0.3),
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
                            fontWeight: FontWeight.bold, fontSize: 24),
                      )),
                  LinearPercentIndicator(
                    // linearStrokeCap: LinearStrokeCap.round,
                    barRadius: const Radius.circular(26),
                    trailing: Row(
                      children: [
                        const Text(
                          '68',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'bpm',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.grey.shade800.withOpacity(0.3),
                    animation: true,
                    percent: 0.5,
                    lineHeight: 18,
                    progressColor: Colors.white,
                  ),
                ],
              ),
            ),
            const Text('Weekly data'),
            ElevatedButton(
                onPressed: () {
                  // max30101.runSampler(onBeat);
                },
                child: const Text('Max 30101'))
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
        'Heart rate',
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

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff727272),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;
  switch (value.toInt()) {
    case 6:
      text = const Text('6:00', style: style);
      break;
    case 10:
      text = const Text('10:00', style: style);
      break;
    case 14:
      text = const Text('02:00', style: style);
      break;
    case 18:
      text = const Text('06:00', style: style);
      break;
    case 22:
      text = const Text('10:00', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return Padding(padding: const EdgeInsets.only(top: 8.0), child: text);
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff67727d),
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = '0';
      break;
    case 40:
      text = '40';
      break;
    case 80:
      text = '80';
      break;
    case 120:
      text = '120';
      break;
    case 160:
      text = '160';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
