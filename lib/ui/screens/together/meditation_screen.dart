import 'package:flutter/material.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({Key? key}) : super(key: key);

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text('Breathing'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              // color: const Color.fromARGB(255, 207, 80, 232),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child:
                    const Padding(padding: EdgeInsets.all(16.0), child: Row()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
