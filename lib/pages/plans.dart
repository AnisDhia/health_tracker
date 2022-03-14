import 'package:flutter/material.dart';
import 'package:health_tracker/widgets/nav-drawer.dart';

class Plans extends StatelessWidget {
  const Plans({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Plans'), 
        centerTitle: true,
      ),
      body: Container(
        child: const Text('Plans'),
      ),
    );
  }
}