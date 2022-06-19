import 'package:flutter/material.dart';
import 'package:health_tracker/data/repositories/firestore.dart';

class QuickAddScreen extends StatefulWidget {
  const QuickAddScreen({Key? key}) : super(key: key);

  @override
  State<QuickAddScreen> createState() => _QuickAddScreenState();
}

class _QuickAddScreenState extends State<QuickAddScreen> {
  late TextEditingController caloriesController;
  late TextEditingController proteinController;
  late TextEditingController carbsController;
  late TextEditingController fatController;
  

  @override
  void initState() {
    super.initState();
    caloriesController = TextEditingController();
    proteinController = TextEditingController();
    carbsController = TextEditingController();
    fatController = TextEditingController();
  }

  @override
  void dispose() {
    caloriesController.dispose();
    proteinController.dispose();
    carbsController.dispose();
    fatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Add'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FireStoreCrud().quickAddMacros(
                    caloriesController.text == '' ? 0 : double.parse(caloriesController.text),
                    proteinController.text == '' ? 0 : double.parse(proteinController.text),
                    fatController.text == '' ? 0 : double.parse(fatController.text),
                    carbsController.text == '' ? 0 : double.parse(carbsController.text));
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(flex: 5, child: Text('Calories')),
                Expanded(
                    child: SizedBox(
                        child: TextField(
                  controller: caloriesController,
                  keyboardType: TextInputType.number,
                ))),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(flex: 5, child: Text('Protein')),
                Expanded(
                    child: SizedBox(
                        child: TextField(
                  controller: proteinController,
                  keyboardType: TextInputType.number,
                ))),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(flex: 5, child: Text('Carbohydrates')),
                Expanded(
                    child: SizedBox(
                        child: TextField(
                  controller: carbsController,
                  keyboardType: TextInputType.number,
                ))),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(flex: 5, child: Text('Fat')),
                Expanded(
                    child: SizedBox(
                        child: TextField(
                  controller: fatController,
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
