import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:health_tracker/data/models/food_model.dart';
import 'package:health_tracker/data/models/product_model.dart';
import 'package:health_tracker/data/repositories/fdc_api.dart';
import 'package:health_tracker/data/repositories/off_api.dart';
import 'package:health_tracker/ui/screens/diary/nutrition/food_details_screen.dart';
import 'package:health_tracker/ui/screens/diary/nutrition/quick_add_screen.dart';
import 'package:health_tracker/ui/screens/diary/nutrition/upc_details_screen.dart';
import 'package:health_tracker/ui/widgets/snackbar_widget.dart';

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
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      log(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
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
                        // ? ALL TAB
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            onTap: () async {
                                              await scanBarcodeNormal();
                                              log(_scanBarcode);
                                              if (_scanBarcode == 'Unknown') {
                                                MySnackBar.error(
                                                    message:
                                                        'Failed, Try again',
                                                    color: Colors.red,
                                                    context: context);
                                              } else {
                                                Product product =
                                                    await OpenFoodFactsAPI
                                                        .instance
                                                        .fetchProductByUPC(
                                                            _scanBarcode /*'6134082000017'*/);
                                                if (!mounted) {
                                                  return;
                                                }
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetailsScreen(
                                                                product:
                                                                    product,
                                                                meal: widget
                                                                    .title)));
                                              }
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.all(16.0),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    // Icons.qr_code_scanner,
                                                    CupertinoIcons.barcode_viewfinder,
                                                    size: 50,
                                                  ),
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Text('Scan a Barcode')
                                                ],
                                              ),
                                            ))),
                                  ),
                                  Expanded(
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const QuickAddScreen()));
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.all(16.0),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.local_fire_department,
                                                    size: 50,
                                                  ),
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Text('Quick Add')
                                                ],
                                              ),
                                            ))),
                                  ),
                                ],
                              ),
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
                                          itemBuilder: ((BuildContext context,
                                              int index) {
                                            String calories = '?';
                                            for (var nutrient in snapshot
                                                .data![index].nutrients) {
                                              if (nutrient['nutrientId'] ==
                                                  1008) {
                                                calories = nutrient['value']
                                                    .toString();
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
                                                              meal:
                                                                  widget.title,
                                                            ))));
                                              },
                                              title: Text(
                                                  snapshot.data![index].name),
                                              trailing:
                                                  Text(calories.toString()),
                                            );
                                          }));
                                    }
                                  })),
                            ],
                          ),
                        ),
                        const Center(child: Text("My Meals")),
                        const Center(child: Text("My Recipes")),
                        const Center(child: Text("My Foods"))
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
