import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/food_model.dart';
import 'package:health_tracker/data/models/product_model.dart';
import 'package:health_tracker/data/repositories/firestore.dart';
import 'package:health_tracker/data/repositories/off_api.dart';
import 'package:health_tracker/ui/widgets/indicator_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.upc, required this.meal})
      : super(key: key);
  final String upc;
  final String meal;

  @override
  State<ProductDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<ProductDetailsScreen> {
  late String meal;
  late double calories, fat, protein, carbs;

  @override
  void initState() {
    super.initState();
    meal = widget.meal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: [
          IconButton(
              onPressed: () {
                FireStoreCrud()
                    .updateDiaryMeal(meal, widget.upc, 'upc', calories, carbs, fat, protein);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: FutureBuilder(
          future: OpenFoodFactsAPI.instance.fetchProductByUPC(widget.upc),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const MyCircularIndicator();
            } else {
              setState(() {
                calories = snapshot.data.nutrients['energy-kcal'];
                protein = snapshot.data.nutrients['proteins'];
                carbs = snapshot.data.nutrients['carbohydrates'];
                fat = snapshot.data.nutrients['fat'];
              });
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data.name,
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
                            itemCount: snapshot.data.nutrients.length,
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(snapshot
                                              .data.nutrients.keys
                                              .elementAt(index))),
                                      Text(snapshot.data.nutrients.values
                                          .elementAt(index)
                                          .toString()),
                                    ],
                                  ),
                                  const Divider()
                                ],
                              );
                            })))
                  ],
                ),
              );
            }
          }),
    );
  }
}
