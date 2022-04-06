import 'package:flutter/material.dart';
import 'package:health_tracker/ui/widgets/drawer_widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Plans'), 
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(children: [
          const SizedBox(height: 40,),
          TabBar(
            isScrollable:true,
            tabs: [
            Tab(
              text: 'Workouts'.toUpperCase(),
            ),
            Tab(
              text: 'Favourites'.toUpperCase(),
            ),
            Tab(
              text: 'Categories'.toUpperCase(),
            )
          ],
          labelColor: Theme.of(context).tabBarTheme.labelColor, //Colors.black,
          indicator: DotIndicator(
            color: Colors.blue,
            distanceFromCenter: 16,
            radius: 3,
            paintingStyle: PaintingStyle.fill,
            ),
          unselectedLabelColor: Theme.of(context).tabBarTheme.unselectedLabelColor,
          labelPadding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          Expanded(child: TabBarView(
            children: [
              Container(
                child: const Center(
                  child: Text("")
                ),
              ),
              Container(

              ),
              Container(

              ),
            ],
          ))
        ],)
      )
    );
  }
}