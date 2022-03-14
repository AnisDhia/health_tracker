import 'package:flutter/material.dart';
import 'package:health_tracker/widgets/nav-drawer.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Health Tracker'), 
        centerTitle: true,
      ),
      body: Container(
        child: const Text('Home'),
      ),
    );
  }
}