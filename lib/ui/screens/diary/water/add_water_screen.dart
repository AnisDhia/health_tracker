import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/data/repositories/firestore.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AddWaterScreen extends StatefulWidget {
  const AddWaterScreen({Key? key}) : super(key: key);

  @override
  State<AddWaterScreen> createState() => _MeassureBPMScreenState();
}

class _MeassureBPMScreenState extends State<AddWaterScreen> {
  int waterValue = 0, waterGoal = 3700;

  @override
  void initState() {
    super.initState();
    fetchWaterValue();
  }

  Future<void> fetchWaterValue() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('diary')
          .doc(DateFormat('d-M-y').format(DateTime.now()))
          .get();
      if (document.data()!.containsKey('water')) {
        setState(() {
          waterValue = document.get('water');
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Water'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FireStoreCrud().updateDiaryWater(waterValue);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              // margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Today',
                          style: TextStyle(fontSize: 20),
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    LinearPercentIndicator(
                      linearGradient: LinearGradient(
                          colors: [Colors.blue.shade800, Colors.blue]),
                      // progressColor: Colors.blue,
                      lineHeight: 28,
                      percent:
                          waterValue > waterGoal ? 1 : waterValue / waterGoal,
                      animation: true,
                      animateFromLastPercent: true,
                      curve: Curves.bounceOut,
                      animationDuration: 800,
                      barRadius: const Radius.circular(24),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (waterValue - 250 >= 0) {
                                  waterValue -= 250;
                                } else {
                                  waterValue = 0;
                                }
                              });
                            },
                            icon: const Icon(Icons.remove)),
                        Text('$waterValue ml'),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                waterValue += 250;
                              });
                            },
                            icon: const Icon(Icons.add)),
                      ],
                    )
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
