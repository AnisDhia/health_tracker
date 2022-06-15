import 'package:flutter/material.dart';
import 'package:health_tracker/data/repositories/firestore.dart';
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
  late TextEditingController bodyFatController;
  late TextEditingController skeletalMuscleController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    bodyFatController = TextEditingController();
    skeletalMuscleController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    bodyFatController.dispose();
    skeletalMuscleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Weight'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22)),
                ),
                TextButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (time == null) return;

                    setState(() {
                      date = DateTime(date.year, date.month, date.day,
                          time.hour, time.minute);
                    });
                  },
                  child: Text(DateFormat('HH:mm').format(date),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22)),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Card(
              // margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
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
                      selectedTextStyle:
                          const TextStyle(color: Colors.red, fontSize: 32),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            // ? BODY FAT / SKELETAL MUSCLE INPUT FIELDS
            Card(
              // margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                            child: Text(
                          'Body fat',
                          style: TextStyle(fontSize: 18),
                        )),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: bodyFatController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const Text('%')
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Expanded(
                            child: Text('Skeletal muscle',
                                style: TextStyle(fontSize: 18))),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: skeletalMuscleController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const Text('kg')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // ? NOTE CARD
            Card(
              // margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.event_note),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: noteController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(hintText: 'Notes'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel', style: TextStyle(fontSize: 24))),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {
                    FireStoreCrud().updateDiaryWeight(date, currentWeight.toString(), bodyFatController.text.trim(), skeletalMuscleController.text.trim(), noteController.text);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 24),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
