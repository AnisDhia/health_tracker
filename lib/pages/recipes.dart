import 'package:flutter/material.dart';
import 'package:health_tracker/widgets/nav-drawer.dart';

class Recipes extends StatelessWidget {
  const Recipes({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Recipes'), 
        centerTitle: true,
      ),
      body: Container(
        child: const Text('Recipes'),
      ),
    );
  }
}