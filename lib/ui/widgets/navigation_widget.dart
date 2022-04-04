import 'package:flutter/material.dart';
import 'package:health_tracker/ui/screens/diary/diary_screen.dart';
import 'package:health_tracker/ui/screens/diary/test.dart';
import 'package:health_tracker/ui/screens/home_screen.dart';
import 'package:health_tracker/ui/screens/plans/plans_screen.dart';
import 'package:health_tracker/ui/screens/recipes/recipes_screen.dart';
import 'package:health_tracker/ui/screens/together_screen.dart';



class Navigation extends StatefulWidget {
  const Navigation({ Key? key }) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 2;
  PageController pageController = PageController();

  final List<Widget> _widgetOption = const <Widget>[
    RecipesScreen(),
    PlansScreen(),
    HomeScreen(),
    DiaryScreen(),
    // FitnessNutritionMainPage(),
    TogetherScreen(),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 2);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      // drawer: const NavDrawer(),
      // appBar: AppBar(
      //   title: const Text('Health Tracker'), 
      //   centerTitle: true,
      // ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: _widgetOption,
        onPageChanged: (index){
          setState(() {
            _selectedIndex = index;
          });
        } ,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Plans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Together',
          ),
        ],
        selectedItemColor: Colors.red,
        selectedIconTheme: const IconThemeData(size: 30),
        currentIndex: _selectedIndex,
        // showUnselectedLabels: false,
        onTap:  _onItemTapped,
      ),   
    );
  }
}