import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

class RecordSleepScreen extends StatefulWidget {
  const RecordSleepScreen({Key? key}) : super(key: key);

  @override
  State<RecordSleepScreen> createState() => _RecordSleepScreenState();
}

class _RecordSleepScreenState extends State<RecordSleepScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Record Sleep'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TimeRangePicker(
                strokeColor: const Color.fromARGB(255, 255, 200, 38),
                handlerColor: const Color.fromARGB(255, 255, 200, 38),
                strokeWidth: 5,
                ticks: 12,
                ticksLength: 5,
                backgroundWidget: const Text(
                  'Sleep Time',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ));
  }
}
