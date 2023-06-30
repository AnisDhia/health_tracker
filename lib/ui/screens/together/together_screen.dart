import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_tracker/shared/services/user_provider.dart';
import 'package:health_tracker/ui/screens/together/meditation_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class TogetherScreen extends StatelessWidget {
  const TogetherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.getUser;
    return Scaffold(
      // drawer: const NavDrawer(),
      // appBar: AppBar(
      //   title: const Text('Together'),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Column(
                    children: [
                      Text(
                        '11',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Level',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  CircularPercentIndicator(
                    radius: 50,
                    lineWidth: 3,
                    // progressColor: const Color.fromARGB(255, 255, 108, 0),
                    linearGradient: const LinearGradient(colors: [
                      Colors.red,
                      Colors.orange,
                    ]),
                    percent: 0.5,
                    backgroundColor: Colors.transparent,
                    animation: true,
                    center: SizedBox(
                      height: 80,
                      width: 80,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoUrl),
                            // AssetImage('assets/images/profile.jpg'),
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                  const Column(
                    children: [
                      Text(
                        '66',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Hours',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                user.username,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              const SizedBox(
                height: 24,
              ),
              const Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 255, 117, 68),
                      radius: 22,
                      child: Icon(
                        FontAwesomeIcons.trophy,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 14,
                  ),
                  Expanded(
                      child: Text(
                    '50%',
                    style: TextStyle(fontSize: 22),
                  )),
                  Text(
                    'Next level',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 121, 125, 142)),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              LinearPercentIndicator(
                percent: 0.5,
                barRadius: const Radius.circular(20),
                linearGradient: const LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.orange,
                  ],
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              // ? SKILLS CIRCULAR INDICATORS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularPercentIndicator(
                    footer: const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Text(
                        '50%',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    center: const Icon(Icons.timer,
                        color: Color.fromARGB(255, 207, 80, 232)),
                    radius: 25,
                    percent: 0.5,
                    progressColor: const Color.fromARGB(255, 207, 80, 232),
                    lineWidth: 4,
                    backgroundColor: const Color(0xFFB8C7CB).withOpacity(0.3),
                  ),
                  CircularPercentIndicator(
                    footer: const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Text(
                        '70%',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    center: const Icon(Icons.directions_run,
                        color: Color.fromARGB(255, 46, 213, 236)),
                    radius: 25,
                    percent: 0.7,
                    progressColor: const Color.fromARGB(255, 46, 213, 236),
                    lineWidth: 4,
                    backgroundColor: const Color(0xFFB8C7CB).withOpacity(0.3),
                  ),
                  CircularPercentIndicator(
                    footer: const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Text(
                        '15%',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    center: const Icon(Icons.fitness_center,
                        color: Color.fromARGB(255, 125, 101, 203)),
                    radius: 25,
                    percent: 0.15,
                    progressColor: const Color.fromARGB(255, 125, 101, 203),
                    lineWidth: 4,
                    backgroundColor: const Color(0xFFB8C7CB).withOpacity(0.3),
                  ),
                  CircularPercentIndicator(
                    footer: const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Text(
                        '25%',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    center: const Icon(Icons.self_improvement_sharp,
                        color: Color.fromARGB(255, 255, 176, 50)),
                    radius: 25,
                    percent: 0.25,
                    progressColor: const Color.fromARGB(255, 255, 176, 50),
                    lineWidth: 4,
                    backgroundColor: const Color(0xFFB8C7CB).withOpacity(0.3),
                  ),
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              // ? DOUBLE COLUMN
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(32.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          '30',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          '# In rating',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 36,
                                        ),
                                        Text(
                                          '46%',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          'Completed',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Image(
                                          image: AssetImage(
                                              'assets/illustrations/Personal goals-amico.png'),
                                          width: 100,
                                          height: 100,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        Card(
                            color: const Color.fromARGB(255, 207, 80, 232),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MeditationScreen()));
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Exercise',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 26,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          'breathing',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 26,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Icon(
                                          Icons.self_improvement,
                                          size: 26,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        Card(
                            color: const Color.fromARGB(255, 252, 103, 39),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Start a',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 26,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          'challenge',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 26,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          size: 26,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
