import 'package:flutter/material.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      // drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Plans'), 
        centerTitle: true,
      ),
      body: const Text('Plans'),
    );
  }
}