import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker/shared/services/user_provider.dart';
import 'package:health_tracker/ui/screens/auth/loading_screen.dart';
import 'package:health_tracker/ui/screens/auth/welcome_screen.dart';
import 'package:health_tracker/ui/screens/diary/diary_screen.dart';
import 'package:health_tracker/ui/screens/home/home_screen.dart';
import 'package:health_tracker/ui/screens/plans/plans_screen.dart';
import 'package:health_tracker/ui/screens/recipes/recipes_screen.dart';
import 'package:health_tracker/ui/screens/together/together_screen.dart';
import 'package:health_tracker/ui/widgets/appbar_widget.dart';
import 'package:health_tracker/ui/widgets/drawer_widget.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
import 'package:health_tracker/ui/widgets/snackbar_widget.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 2;
  PageController pageController = PageController();
  bool isLoading = false;

  final List<Widget> _widgetOption = const <Widget>[
    RecipesScreen(),
    PlansScreen(),
    HomeScreen(),
    DiaryScreen(),
    TogetherScreen(),
  ];

  final List<String> _screenTitles = const <String>[
    'Recipes',
    'Plans',
    'Health Tracker',
    'Diary',
    'Together',
  ];

  @override
  void initState() {
    super.initState();
    addData();
    pageController = PageController(initialPage: 2);
  }

  addData() async {
    setState(() {
      isLoading = true;
    });
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
    setState(() {
      isLoading = false;
    });
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
    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            // extendBody: true,
            appBar: CustomAppBar(title: _screenTitles[_selectedIndex]),
            drawer: const NavDrawer(),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: _widgetOption,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
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
                  icon: Icon(Icons.home),
                  label: 'Home',
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
              onTap: _onItemTapped,
            ),
          );
  }
}
