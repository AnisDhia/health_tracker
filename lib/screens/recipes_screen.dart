import 'package:flutter/material.dart';
import 'package:health_tracker/widgets/drawer_widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

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
        elevation: 0,
        title: const Text('Recipes'), 
        centerTitle: true,
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(children: [
            const SizedBox(height: 40,),
            TabBar(
              isScrollable: true,
              tabs: [
              Tab(
                text: 'New Recipes'.toUpperCase(),
              ),
              Tab(
                text: 'Favourites'.toUpperCase(),
              ),
              Tab(
                text: 'Categories'.toUpperCase(),
              )
            ],
            labelColor: Colors.black,
            indicator: DotIndicator(
              color: Colors.red,
              distanceFromCenter: 16,
              radius: 3,
              paintingStyle: PaintingStyle.fill,
              ),
            unselectedLabelColor: Colors.black.withOpacity(0.3),
            labelPadding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    child: const Center(
                      child: Text("New")
                      ),
                  ),
                  Container(
                    child: const Center(
                      child: Text("Favourites")
                      ),
                  ),
                  Container(
                    child: const Center(
                      child: Text("Categories")
                      ),
                  ),
                ]
              ),
            )
          ],)
        ),
      )
    );
  }
}