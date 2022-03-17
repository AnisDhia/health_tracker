import 'package:flutter/material.dart';
import 'package:health_tracker/widgets/nav-drawer.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({ Key? key }) : super(key: key);

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