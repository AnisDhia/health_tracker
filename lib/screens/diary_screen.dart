import 'package:flutter/material.dart';
import 'package:health_tracker/widgets/drawer.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({ Key? key }) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Diary'), 
        centerTitle: true,
      ),
      body: Container(
        child: const Text('Diary'),
      ),
    );
  }
}