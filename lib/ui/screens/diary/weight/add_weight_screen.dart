import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen({Key? key}) : super(key: key);

  @override
  State<AddWeightScreen> createState() => _MeassureBPMScreenState();
}

class _MeassureBPMScreenState extends State<AddWeightScreen> {
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  double currentWeight = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Weight'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now());

                  if (newDate == null) return;

                  setState(() {
                    date = newDate;
                  });
                },
                child: Text(DateFormat('EEE, MMMM d').format(date),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () async {
                  final time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());

                  if (time == null) return;

                  setState(() {
                    date = DateTime(date.year, date.month, date.day, time.hour,
                        time.minute);
                  });
                },
                child: Text(DateFormat('HH:mm').format(date),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Card(
            // margin: const EdgeInsets.all(8.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Weight (kg)'),
                  DecimalNumberPicker(
                    minValue: 0,
                    maxValue: 1000,
                    value: currentWeight,
                    onChanged: (newWeight) {
                      setState(() {
                        currentWeight = newWeight;
                      });
                    },
                    // integerDecoration: TextDecoration(),                    
                  ),
                  // Row(
                  //   children: const [
                  //     SizedBox(
                  //       width: 50,
                  //       height: 30,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          Card(
            // margin: const EdgeInsets.all(8.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text('Body fat'),
                      // TextField()
                    ],
                  ),
                  Row(
                    children: const [
                      Text('Skeletal muscle'),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
