import 'package:flutter/material.dart';
import 'package:health_tracker/pages/diary.dart';
import 'package:health_tracker/pages/home.dart';
import 'package:health_tracker/pages/plans.dart';
import 'package:health_tracker/pages/profile.dart';
import 'package:health_tracker/widgets/nav-drawer.dart';


class Navigation extends StatefulWidget {
  const Navigation({ Key? key }) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  // static final List<Widget> _widgetOption = <Widget>[
  //   const Home(),
  //   const Profile(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Health Tracker'), 
        centerTitle: true,
      ),
      body: PageView(
        controller: pageController,
        children: const <Widget>[
          Home(),
          Diary(),
          Plans(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Plans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        // showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}