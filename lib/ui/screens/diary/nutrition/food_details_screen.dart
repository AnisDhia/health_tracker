import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/food_model.dart';
import 'package:health_tracker/data/repositories/firestore.dart';
import 'package:health_tracker/shared/services/firestore_service.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({Key? key, required this.food, required this.meal})
      : super(key: key);
  final Food food;
  final String meal;

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  late String meal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    meal = widget.meal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food'),
        actions: [
          IconButton(
              onPressed: () {
                FireStoreCrud().updateDiaryMeal(meal, widget.food.id, 'fdc');
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.food.name,
              style: const TextStyle(fontSize: 24),
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(
                  child: Text('Meal'),
                ),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: const Text('Meals'),
                              children: [
                                SimpleDialogOption(
                                    child: const Text('Breakfast'),
                                    onPressed: () {
                                      setState(() {
                                        meal = 'Breakfast';
                                      });
                                      Navigator.pop(context);
                                    }),
                                SimpleDialogOption(
                                    child: const Text('Lunch'),
                                    onPressed: () {
                                      setState(() {
                                        meal = 'Lunch';
                                      });
                                      Navigator.pop(context);
                                    }),
                                SimpleDialogOption(
                                    child: const Text('Dinner'),
                                    onPressed: () {
                                      setState(() {
                                        meal = 'Dinner';
                                      });
                                      Navigator.pop(context);
                                    }),
                                SimpleDialogOption(
                                    child: const Text('Snacks'),
                                    onPressed: () {
                                      setState(() {
                                        meal = 'Snacks';
                                      });
                                      Navigator.pop(context);
                                    }),
                              ],
                            );
                          });
                    },
                    child: Text(
                      meal,
                      style: const TextStyle(color: Colors.red),
                    ))
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Text('Number of Servings')),
                TextButton(
                    onPressed: () {
                      // showDialog(context: context, builder: builder)
                    },
                    child: const Text('will be added soon'))
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Text('Serving Size')),
                TextButton(
                    onPressed: () {
                      // showDialog(context: context, builder: builder)
                    },
                    child: const Text('will be added soon'))
              ],
            ),
            const Divider(),
            Expanded(
                child: ListView.builder(
                    itemCount: widget.food.nutrients.length,
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(widget.food.nutrients[index]
                                      ['nutrientName'])),
                              Text(
                                  '${widget.food.nutrients[index]['value']} ${widget.food.nutrients[index]['unitName']}'
                                      .toLowerCase()),
                            ],
                          ),
                          const Divider()
                        ],
                      );
                    })))
          ],
        ),
      ),
    );
  }
}
