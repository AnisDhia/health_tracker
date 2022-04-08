// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;

// import 'package:health_tracker/ui/screens/diary/widgets/meal_card_widget.dart';

// class FitnessNutritionMainPage extends StatefulWidget {
//   const FitnessNutritionMainPage({Key? key}) : super(key: key);

//   @override
//   State<FitnessNutritionMainPage> createState() => _FitnessNutritionMainPageState();
// }

// class _FitnessNutritionMainPageState extends State<FitnessNutritionMainPage> {
//   int _index = 0;
//   int _topIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 72,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         // color: Colors.blue,
//                         ),
//                     child: ListView.builder(
//                       itemCount: 5,
//                       itemBuilder: (context, index) {
//                         var _day = DateTime.now().add(Duration(days: index));
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _topIndex = index;
//                             });
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
//                             child: Container(
//                               height: 58,
//                               width: 58,
//                               decoration: BoxDecoration(
//                                 color: Colors.black,
//                                 borderRadius: BorderRadius.circular(6),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.white.withOpacity(0.2),
//                                     offset: const Offset(-1, -1),
//                                   )
//                                 ],
//                                 gradient: _topIndex == index
//                                     ? const LinearGradient(
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight,
//                                         colors: [
//                                             Colors.red,
//                                             Colors.deepOrange,
//                                             Colors.yellow,
//                                             Colors.green,
//                                             Colors.blue,
//                                           ])
//                                     : null,
//                               ),
//                               padding: EdgeInsets.all(_topIndex == index ? 2 : 0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.black,
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       _day.day.toString(),
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 4,
//                                     ),
//                                     Text(
//                                       weeklyConverter(_day.weekday),
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           color: _topIndex == index ? null : Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           foreground: _topIndex == index
//                                               ? (ui.Paint()
//                                                 ..shader = ui.Gradient.linear(const Offset(0, 0), const Offset(50, 0), [
//                                                   Colors.red,
//                                                   Colors.deepOrange,
//                                                   Colors.yellow,
//                                                   Colors.green,
//                                                   Colors.blueAccent,
//                                                 ], [
//                                                   0.0,
//                                                   0.25,
//                                                   0.5,
//                                                   0.75,
//                                                   1.0
//                                                 ]))
//                                               : null),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                       scrollDirection: Axis.horizontal,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 SizedBox(
//                   height: 100,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.all(8),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: const [
//                             Text(
//                               "OBJECTIVE COMPLETION",
//                               style: TextStyle(color: Colors.grey, fontSize: 12),
//                             ),
//                             Icon(
//                               Icons.chevron_right,
//                               color: Colors.grey,
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: const [
//                             Text(
//                               "40%",
//                               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//                             ),
//                             Spacer(),
//                             Text(
//                               "1159",
//                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
//                             ),
//                             Text(
//                               " / 3000 Kcal",
//                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
//                             )
//                           ],
//                         ),
//                         Container(
//                           height: 8,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: MediaQuery.of(context).size.width / 1.8,
//                                 decoration: BoxDecoration(
//                                   color: Colors.red,
//                                   borderRadius: BorderRadius.circular(8),
//                                   gradient: const LinearGradient(
//                                     colors: [
//                                       Colors.blue,
//                                       Colors.green,
//                                       Colors.lightGreenAccent,
//                                       Colors.yellowAccent,
//                                       Colors.orangeAccent,
//                                       Colors.deepOrange,
//                                       Colors.red,
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 const DiaryMealCard(),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white.withOpacity(0.2),
//         currentIndex: _index,
//         type: BottomNavigationBarType.fixed,
//         onTap: (idx) {
//           if (idx == 2) {
//             showModalBottomSheet(
//                 // isScrollControlled: false,
//                 enableDrag: false,
//                 context: context,
//                 builder: (context) => Container());
//           }
//           setState(() {
//             _index = idx;
//           });
//         },
//         backgroundColor: Colors.white.withOpacity(0.1),
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.room_service,
//               ),
//               label: "meal plan"),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.format_list_bulleted,
//               ),
//               label: "meal plan"),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.signal_cellular_alt,
//               ),
//               label: "meal plan"),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.shopping_bag,
//               ),
//               label: "meal plan"),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.settings,
//               ),
//               label: "meal plan"),
//         ],
//       ),
//     );
//   }

//   String weeklyConverter(int weekly) {
//     switch (weekly) {
//       case 1:
//         return "mon";
//       case 2:
//         return "tue";
//       case 3:
//         return "wed";
//       case 4:
//         return "thr";
//       case 5:
//         return "fri";
//       case 6:
//         return "sat";
//       case 7:
//         return "sun";
//       default:
//         return "??";
//     }
//   }
// }

