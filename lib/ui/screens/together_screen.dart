import 'package:flutter/material.dart';
import 'package:health_tracker/ui/widgets/drawer_widget.dart';

class TogetherScreen extends StatelessWidget {
  const TogetherScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Together'), 
        centerTitle: true,
      ),
      body: Container(
        child: const Text('Together screen'),
      ),
    );
  }
}