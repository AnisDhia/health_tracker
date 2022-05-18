import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/data/models/food_model.dart';
import 'package:health_tracker/data/repositories/fdc_api.dart';
import 'package:health_tracker/ui/screens/diary/nutrition/food_details_screen.dart';
import 'package:health_tracker/ui/widgets/search_field_widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AddMealScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddMealScreen> {
  late TextEditingController _searchController;
  // Future<List<Food>> results = [] as Future<List<Food>>;
  String query = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ? SEARCH FIELD
          TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: (newQuery) {
              setState(() {
                query = newQuery;
              });
              log(query);
            },
            decoration: InputDecoration(
              icon: const Icon(
                Icons.search,
              ),
              suffixIcon: IconButton(
                  onPressed: _searchController.clear,
                  icon: const Icon(Icons.close)),
              hintText: 'Search for a food',
              // hintStyle: style,
              border: InputBorder.none,
            ),
          ),
          // ? TAB
          Expanded(
            child: DefaultTabController(
                length: 4,
                initialIndex: 0,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      tabs: const [
                        Tab(
                          text: 'All',
                        ),
                        Tab(
                          text: 'My Meals',
                        ),
                        Tab(
                          text: 'My Recipes',
                        ),
                        Tab(
                          text: 'My Foods',
                        )
                      ],
                      labelColor: Theme.of(context)
                          .tabBarTheme
                          .labelColor, //Colors.black,
                      indicatorColor: Colors.red,
                      unselectedLabelColor:
                          Theme.of(context).tabBarTheme.unselectedLabelColor,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    Expanded(
                        child: TabBarView(
                      children: [
                        FutureBuilder(
                            future: FoodDataCentralService.instance
                                .searchFood(query),
                            builder: ((BuildContext context,
                                AsyncSnapshot<List<Food>> snapshot) {
                              if (snapshot.data == null) {
                                return const Text('no data');
                              } else {
                                return ListView.builder(
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        ((BuildContext context, int index) {
                                      String calories = '?';
                                      for (var nutrient
                                          in snapshot.data![index].nutrients) {
                                        if (nutrient['nutrientId'] == 1008) {
                                          calories =
                                              nutrient['value'].toString();
                                        }
                                      }
                                      return ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      FoodDetailsScreen(
                                                        food: snapshot
                                                            .data![index],
                                                        meal: widget.title,
                                                      ))));
                                        },
                                        title: Text(snapshot.data![index].name),
                                        trailing: Text(calories.toString()),
                                      );
                                    }));
                              }
                            })),
                        Container(
                          child: const Center(child: Text("My Meals")),
                        ),
                        Container(
                          child: const Center(child: Text("My Recipes")),
                        ),
                        Container(
                          child: const Center(child: Text("My Foods")),
                        )
                      ],
                    ))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
