import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/ui/screens/home/add_post_screen.dart';
import 'package:health_tracker/ui/screens/home/widgets/postcard_widget.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';
// import 'package:health_tracker/ui/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: ((context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const MyCircularIndicator();
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child:
                              PostCard(snap: snapshot.data!.docs[index].data()),
                        );
                      }));
                }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPostScreen(),
              ));
        },
      ),
    );
  }
}
