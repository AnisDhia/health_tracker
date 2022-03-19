import 'package:flutter/material.dart';
import 'package:health_tracker/widgets/drawer.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({ Key? key }) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Recipes'), 
        centerTitle: true,
      ),
      body: const Text("Recipes") 
    );
  }
}