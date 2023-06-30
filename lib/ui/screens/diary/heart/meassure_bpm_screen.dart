import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';

class MeassureBPMScreen extends StatefulWidget {
  const MeassureBPMScreen({Key? key}) : super(key: key);

  @override
  State<MeassureBPMScreen> createState() => _MeassureBPMScreenState();
}

class _MeassureBPMScreenState extends State<MeassureBPMScreen> {
  List<SensorValue> data = [];
  List<SensorValue> bpmValues = [];
  //  Widget chart = BPMChart(data);

  bool isBPMEnabled = false;
  Widget? dialog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measure heart rate'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (isBPMEnabled) {
                                    isBPMEnabled = false;
                                    // dialog.
                                  } else {
                                    isBPMEnabled = true;
                                  }
                                });
                              },
                              icon: const Icon(
                                FontAwesomeIcons.heartPulse,
                                size: 36,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(isBPMEnabled
                                ? 'Put your finger on the camera'
                                :'Press the heart to measure BPM')
                          ],
                        )
                      ]),
                ),
              ),
              isBPMEnabled
                  ? dialog = HeartBPMDialog(
                      context: context,
                      onRawData: (value) {
                        setState(() {
                          if (data.length >= 100) data.removeAt(0);
                          data.add(value);
                        });
                        // chart = BPMChart(data);
                      },
                      onBPM: (value) => setState(() {
                        if (bpmValues.length >= 100) bpmValues.removeAt(0);
                        bpmValues.add(SensorValue(
                            value: value.toDouble(), time: DateTime.now()));
                      }),
                      // sampleDelay: 1000 ~/ 20,
                      // child: Container(
                      //   height: 50,
                      //   width: 100,
                      //   child: BPMChart(data),
                      // ),
                    )
                  : const SizedBox(),
              isBPMEnabled && data.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(border: Border.all()),
                      height: 180,
                      child: BPMChart(data),
                    )
                  : const SizedBox(),
              isBPMEnabled && bpmValues.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(border: Border.all()),
                      constraints: const BoxConstraints.expand(height: 180),
                      child: BPMChart(bpmValues),
                    )
                  : const SizedBox(),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(Icons.circle, size: 6),
                                Text(' Don\'t press too hard.')
                              ]),
                              Row(children: [
                                Icon(Icons.circle, size: 6),
                                Text(' Remain still and quiet.')
                              ]),
                              Row(children: [
                                Icon(Icons.circle, size: 6),
                                Expanded(
                                  child: Text(
                                      ' You\'ll see a steady wave while your finger is in the correct position on the camera.'),
                                )
                              ]),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
