import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircularPercentIndicator(
                  radius: 50,
                  lineWidth: 3,
                  progressColor: const Color.fromARGB(255, 255, 108, 0),
                  percent: 0.7,
                  backgroundColor: Colors.transparent,
                  animation: true,
                  center: const SizedBox(
                    height: 80,
                    width: 80,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                const VerticalDivider(
                  width: 30,
                  thickness: 10,
                  color: Colors.amber,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Joined',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontFamily: 'Avenir'),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      '6 mon ago',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontFamily: 'Avenir'),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Anis',
              style: Theme.of(context).textTheme.headline3,
            ),
            const Text(
              'Dhia',
            ),
            Card(
              // margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Row(
                    children: const [
                      SizedBox(
                        width: 50,
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: const Text('Profile'),
      centerTitle: true,
      actions: [
        PopupMenuButton(
            itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                      value: 0, child: Text('Edit Profile')),
                  const PopupMenuItem(child: Text('Edit Profile')),
                  const PopupMenuItem(child: Text('Edit Profile')),
                ]),
        // IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
      ],
    );
  }
}
