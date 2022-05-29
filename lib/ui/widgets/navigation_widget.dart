import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker/bloc/auth/authentication_cubit.dart';
import 'package:health_tracker/bloc/connectivity/connectivity_cubit.dart';
import 'package:health_tracker/shared/services/user_provider.dart';
import 'package:health_tracker/ui/screens/auth/welcome_screen.dart';
import 'package:health_tracker/ui/screens/diary/diary_screen.dart';
import 'package:health_tracker/ui/screens/home/home_screen.dart';
import 'package:health_tracker/ui/screens/plans_screen.dart';
import 'package:health_tracker/ui/screens/recipes/recipes_screen.dart';
import 'package:health_tracker/ui/screens/together/together_screen.dart';
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
    addData();
    pageController = PageController(initialPage: 2);
  }

  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
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
    AuthenticationCubit authenticationCubit = BlocProvider.of(context);
    // ConnectivityCubit connectivityCubit = BlocProvider.of(context);

    return Scaffold(
      // extendBody: true,
      drawer: NavDrawer(authenticationCubit: authenticationCubit),
      body: MultiBlocListener(
          listeners: [
            BlocListener<ConnectivityCubit, ConnectivityState>(
                listener: (context, state) {
              if (state is ConnectivityOnlineState) {
                MySnackBar.error(
                    message: 'Connected', color: Colors.blue, context: context);
              } else {
                MySnackBar.error(
                    message: 'Please Check Your Internet Connection',
                    color: Colors.red,
                    context: context);
              }
            }),
            BlocListener<AuthenticationCubit, AuthenticationState>(
                listener: (context, state) {
              if (state is UnAuthenticationState) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                    (route) => false);
              }
            })
          ],
          child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationLoadingState) {
                return const MyCircularIndicator();
              }
              return PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: _widgetOption,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              );
            },
          )),
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
        onTap: _onItemTapped,
      ),
    );
  }
}
