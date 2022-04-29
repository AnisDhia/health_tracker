import 'package:flutter/material.dart';
// import 'package:health_tracker/ui/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  // late List<Post> _posts;

  // void _fetchPosts()  async {
  //   _posts = 
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      // drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Health Tracker'), 
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('home'),
            // FutureBuilder(
            //   future: _posts,
            //   builder: ((context, snapshot) {
              
            // })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () {
          // TODO: implement diary FAB functionality
        },
      ),
    );
  }
}