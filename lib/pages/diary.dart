import 'package:flutter/material.dart';
import 'package:health_tracker/widgets/nav-drawer.dart';

class Diary extends StatefulWidget {
  const Diary({ Key? key }) : super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
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