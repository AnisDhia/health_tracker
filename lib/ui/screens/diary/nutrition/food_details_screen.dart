import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/food_model.dart';
import 'package:health_tracker/data/repositories/firestore.dart';
import 'package:pie_chart/pie_chart.dart' as pie;

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({Key? key, required this.food, required this.meal})
      : super(key: key);
  final Food food;
  final String meal;

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  late String meal, servingUnit;
  TimeOfDay time = TimeOfDay.now();
  late TextEditingController servingsController;
  late TextEditingController servingUnitController;
  late double servings, servingSize;
  late Map<String, dynamic> protein, fat, carbs, calories;

  @override
  void initState() {
    super.initState();
    servingUnitController = TextEditingController();
    servingsController = TextEditingController();
    meal = widget.meal;
    servingSize = widget.food.servingSize ?? 0;
    servingUnit = widget.food.servingSizeUnit ?? 'g';
    protein = widget.food.nutrientFromMap(1003);
    fat = widget.food.nutrientFromMap(1004);
    carbs = widget.food.nutrientFromMap(1005);
    calories = widget.food.nutrientFromMap(1008);
    servings = widget.food.numberOfServings!;
  }

  @override
  void dispose() {
    servingUnitController.dispose();
    servingsController.dispose();
    super.dispose();
  }

  dynamic macroPercentage(double value, int type) {
    double calories =
        (protein['value'] * 4 + carbs['value'] * 4 + fat['value'] * 9)
            .toDouble();
    if (calories == 0) {
      return 0.toDouble();
    } else if (type == 1) {
      return ((value * 4 / calories) * 100).round();
    } else {
      return ((value * 9 / calories) * 100).round();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Food'),
        actions: [
          IconButton(
              onPressed: () {
                FireStoreCrud().updateDiaryMeal(
                  meal,
                  widget.food.id,
                  'fdc',
                  widget.food.name,
                  calories['value'].toDouble(),
                  carbs['value'].toDouble(),
                  fat['value'].toDouble(),
                  protein['value'].toDouble(),
                );
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
                      _servingsDialog(context);
                    },
                    child: Text(servings.toString()))
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Text('Serving Size')),
                TextButton(
                    onPressed: () {
                      _servingsDialog(context);
                    },
                    child: Text('$servingSize ${widget.food.servingSizeUnit}'))
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Text('Time')),
                TextButton(
                  onPressed: () async {
                    final newTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (newTime == null) return;

                    setState(() {
                      time = newTime;
                    });
                  },
                  child: Text('${time.hour}:${time.minute}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Divider(),
            // ? CHART
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Column(
                      children: [
                        Text(calories['value'].toString()),
                        Text(calories['unitName'].toLowerCase()),
                      ],
                    ),
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: pie.PieChart(
                        dataMap: {
                          'Carbs': carbs['value'].toDouble(),
                          'Fat': fat['value'].toDouble(),
                          'Protein': protein['value'].toDouble(),
                        },
                        chartType: pie.ChartType.ring,
                        baseChartColor: Colors.grey.shade900,
                        colorList: const [
                          Color.fromARGB(255, 0, 210, 124),
                          Color.fromARGB(255, 128, 71, 246),
                          Color.fromARGB(255, 254, 164, 44)
                        ],
                        legendOptions:
                            const pie.LegendOptions(showLegends: false),
                        chartValuesOptions: const pie.ChartValuesOptions(
                            showChartValues: false),
                        ringStrokeWidth: 6,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '${macroPercentage(carbs['value'].toDouble(), 1)}%',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 210, 124)),
                    ),
                    Text('${carbs['value']} ${carbs['unitName'].toLowerCase()}',
                        style: const TextStyle(fontSize: 20)),
                    const Text('Carbs'),
                  ],
                ),
                Column(
                  children: [
                    Text('${macroPercentage(fat['value'].toDouble(), 2)}%',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 128, 71, 246))),
                    Text('${fat['value']} ${fat['unitName'].toLowerCase()}',
                        style: const TextStyle(fontSize: 20)),
                    const Text('Fat'),
                  ],
                ),
                Column(
                  children: [
                    Text('${macroPercentage(protein['value'].toDouble(), 1)}%',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 254, 164, 44))),
                    Text(
                        '${protein['value']} ${protein['unitName'].toLowerCase()}',
                        style: const TextStyle(fontSize: 20)),
                    const Text('Protein'),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
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

  Future<dynamic> _servingsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(16),
            title: const Text('How Much?'),
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: servingsController,
                    ),
                  ),
                  const Text('Serving(s) of')
                ],
              ),
              DropdownButton<double>(
                  value: servingSize,
                  items: [
                    DropdownMenuItem(
                      value: widget.food.servingSize,
                      child: Text('${widget.food.servingSize} g'),
                    ),
                    const DropdownMenuItem(
                      value: 100,
                      child: Text('100 g'),
                    ),
                    const DropdownMenuItem(
                      value: 1,
                      child: Text('1 g'),
                    ),
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      servingSize = newValue!;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (servingsController.text.isNotEmpty) {
                        setState(() {
                          servings = double.parse(servingsController.text);
                        });
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('save'),
                  )
                ],
              )
            ],
          );
        });
  }
}
