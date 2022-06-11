import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/product_model.dart';
import 'package:health_tracker/data/repositories/firestore.dart';
import 'package:pie_chart/pie_chart.dart' as pie;

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(
      {Key? key, required this.meal, required this.product})
      : super(key: key);
  final String meal;
  final Product product;

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
    calories = widget.product.nutrients['energy-kcal'].toDouble();
    protein = widget.product.nutrients['proteins'].toDouble();
    carbs = widget.product.nutrients['carbohydrates'].toDouble();
    fat = widget.product.nutrients['fat'].toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
          actions: [
            IconButton(
                onPressed: () {
                  FireStoreCrud().updateDiaryMeal(
                      meal,
                      widget.product.upc,
                      'upc',
                      widget.product.name,
                      calories,
                      carbs,
                      fat,
                      protein);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check))
          ],
        ),
        body:
            // FutureBuilder(
            //     future: OpenFoodFactsAPI.instance.fetchProductByUPC(widget.upc),
            //     builder: (context, AsyncSnapshot<Product> snapshot) {
            //       if (!snapshot.hasData) {
            //         return const MyCircularIndicator();
            //       } else {
            // setState(() {
            //   calories = snapshot.data!.nutrients['energy-kcal'].toDouble();
            //   protein = snapshot.data!.nutrients['proteins'].toDouble();
            //   carbs = snapshot.data!.nutrients['carbohydrates'].toDouble();
            //   fat = snapshot.data!.nutrients['fat'].toDouble();
            //   name = snapshot.data!.name;
            // });
            // return
            Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Image(image: NetworkImage(widget.product.imageUrl!)),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(
                          widget.product.description ?? '',
                        ),
                      ],
                    ),
                  ),
                ],
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
              // ? CHART
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        children: [
                          Text(calories.toString()),
                          Text(widget.product.nutrients['energy-kcal_unit']
                              .toLowerCase()),
                        ],
                      ),
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: pie.PieChart(
                          dataMap: {
                            'Carbs': carbs,
                            'Fat': fat,
                            'Protein': protein,
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
                        calories == 0
                            ? '0%'
                            : '${macroPercentage(carbs, 1).round()}%',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 210, 124)),
                      ),
                      Text(
                          '$carbs ${widget.product.nutrients['carbohydrates_unit']}',
                          style: const TextStyle(fontSize: 20)),
                      const Text('Carbs'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                          calories == 0
                              ? '0%'
                              : '${macroPercentage(fat, 2).floor()}%',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 128, 71, 246))),
                      Text('$fat ${widget.product.nutrients['fat_unit']}',
                          style: const TextStyle(fontSize: 20)),
                      const Text('Fat'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                          calories == 0
                              ? '0%'
                              : '${macroPercentage(protein, 1).round()}%',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 254, 164, 44))),
                      Text(
                          '$protein ${widget.product.nutrients['proteins_unit']}',
                          style: const TextStyle(fontSize: 20)),
                      const Text('Protein'),
                    ],
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                  child: ListView.builder(
                      itemCount: widget.product.nutrients.length,
                      itemBuilder: ((context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(widget.product.nutrients.keys
                                        .elementAt(index))),
                                Text(widget.product.nutrients.values
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
        )
        //   }
        // }),
        );
  }

  double macroPercentage(double value, int type) {
    double calories = protein * 4 + carbs * 4 + fat * 9;
    if (type == 1) {
      return (value * 4 / calories) * 100;
    } else {
      return (value * 9 / calories) * 100;
    }
  }
}
