import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
// import 'package:health_tracker/pages/home.dart';
import 'package:health_tracker/themes.dart';
import 'package:health_tracker/utils/user_preferences.dart';
import 'package:health_tracker/widgets/navigation.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await UserPreferences.init();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Health Tracker';
  
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      builder: (context, myTheme) {
          return MaterialApp(
            title: title,
            debugShowCheckedModeBanner: false,
            theme: myTheme,
            home: const Navigation(),
          );
        }
      );
  }
}
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0, _selectedIndex = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
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
        selectedItemColor: Colors.red,
        currentIndex: _selectedIndex,
        // showUnselectedLabels: false,
        onTap: _onItemTapped,
        ),
    );
  }
}
*/