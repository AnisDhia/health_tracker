import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/pages/diary.dart';
import 'package:health_tracker/pages/home.dart';
import 'package:health_tracker/pages/plans.dart';
import 'package:health_tracker/pages/profile.dart';
import 'package:health_tracker/pages/recipes.dart';
import 'package:health_tracker/widgets/nav-drawer.dart';
import 'package:health_tracker/utils/user_preferences.dart';



class Navigation extends StatefulWidget {
  const Navigation({ Key? key }) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 2;
  PageController pageController = PageController();

  static const List<Widget> _widgetOption = <Widget>[
    Recipes(),
    Plans(),
    Home(),
    Diary(),
    Profile(),
  ];
  var items = const[
    Icon(Icons.fastfood, size: 30),
    Icon(Icons.list, size: 30),
    Icon(Icons.home, size: 30),
    Icon(Icons.query_stats, size: 30),
    Icon(Icons.person, size: 30),
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
    pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // drawer: const NavDrawer(),
      // appBar: AppBar(
      //   title: const Text('Health Tracker'), 
      //   centerTitle: true,
      // ),
      body: PageView(
        
        controller: pageController,
        children: _widgetOption,
        onPageChanged: (index){
          setState(() {
            _selectedIndex = index;
          });
        } ,
      ),
      
      // bottomNavigationBar: CurvedNavigationBar(
      //   color: Colors.grey.shade900,
      //   backgroundColor: Colors.transparent,
      //   buttonBackgroundColor: Colors.red,
      //   height: 60,
      //   index: _selectedIndex,
      //   items: items,
      //   // onTap: (_selectedIndex) => setState(() => this._selectedIndex = _selectedIndex),
      //   onTap: _onItemTapped,
      // ),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Plans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.red,
        currentIndex: _selectedIndex,
        // showUnselectedLabels: false,
        onTap:  _onItemTapped,
      ),
      
    );
  }
}