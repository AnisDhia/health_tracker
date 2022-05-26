import 'package:flutter/material.dart';

class QuickAddScreen extends StatefulWidget {
  const QuickAddScreen({Key? key}) : super(key: key);

  @override
  State<QuickAddScreen> createState() => _QuickAddScreenState();
}

class _QuickAddScreenState extends State<QuickAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Add'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(flex: 5, child: const Text('Calories')),
                Expanded(
                    child: SizedBox(
                        child: TextField(
                  keyboardType: TextInputType.number,
                ))),
              ],
            ),
            const Divider(),
            Row(
              children: const [
                Expanded(flex: 5, child: const Text('Protein')),
                Expanded(
                    child: SizedBox(
                        child: TextField(
                  keyboardType: TextInputType.number,
                ))),
              ],
            ),
            const Divider(),
            Row(
              children: const [
                Expanded(flex: 5, child: const Text('Carbohydrates')),
                Expanded(
                    child: SizedBox(
                        child: TextField(
                  keyboardType: TextInputType.number,
                ))),
              ],
            ),
            const Divider(),
            Row(
              children: const [
                Expanded(flex: 5, child: const Text('Fat')),
                Expanded(
                    child: SizedBox(
                        child: TextField(
                  keyboardType: TextInputType.number,
                ))),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
