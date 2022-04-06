import 'package:flutter/material.dart';
import 'package:health_tracker/ui/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      // drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Health Tracker'), 
        centerTitle: true,
      ),
      body: Container(
        child: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () {
          // TODO: implement diary FAB functionality
        },
      ),
    );
  }
}