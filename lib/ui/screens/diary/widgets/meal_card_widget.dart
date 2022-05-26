// import 'package:flutter/material.dart';
// import 'package:health_tracker/data/models/food_model.dart';

// class DiaryMealCard extends StatefulWidget {
//   final String title;

//   const DiaryMealCard({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   @override
//   State<DiaryMealCard> createState() => _DiaryMealCardState();
// }

// class _DiaryMealCardState extends State<DiaryMealCard> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 540,
//       width: double.infinity,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(8),
//           gradient: const LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               // Colors.blue,
//               // Colors.green,
//               // Colors.lightGreenAccent,
//               // Colors.yellowAccent,
//               // Colors.orangeAccent,
//               Colors.deepOrange,
//               Colors.red,
//             ],
//           ),
//         ),
//         padding: const EdgeInsets.all(1.5),
//         child: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: Theme.of(context).scaffoldBackgroundColor,
//           ),
//           child: Container(
//             height: double.infinity,
//             width: double.infinity,
//             // decoration: BoxDecoration(
//             //   color: Theme.of(context).dividerColor.withOpacity(0.05),
//             // ),
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.check,
//                       // color: Colors.white,
//                     ),
//                     Text(
//                       widget.title,
//                       style: const TextStyle(
//                         // color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Spacer(),
//                     TextButton(
//                       onPressed: () {},
//                       style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color?>(
//                               Theme.of(context).dividerColor.withOpacity(0.1)),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(18.0),
//                           ))),
//                       child: Row(
//                         children: const [
//                           Icon(
//                             Icons.refresh,
//                             color: Colors.grey,
//                           ),
//                           SizedBox(
//                             width: 4,
//                           ),
//                           Text(
//                             "REPLACE",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 Expanded(
//                     child: ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return FoodCard(
//                         food: Food(
//                             name: "Smoking Salmon",
//                             weight: 232,
//                             nutrients: []));
//                   },
//                 )),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   height: 64,
//                   child: Row(
//                     children: const [
//                       Expanded(
//                           child: MacroCard(
//                               name: "",
//                               count: 748,
//                               unit: "kcal",
//                               color: Color.fromARGB(255, 7, 165, 201),
//                               icon: Icons.local_fire_department)),
//                       SizedBox(
//                         width: 8,
//                       ),
//                       Expanded(
//                           child: MacroCard(
//                               name: "Carbs",
//                               count: 70,
//                               unit: "g",
//                               color: Color.fromARGB(255, 255, 208, 70),
//                               icon: Icons.rice_bowl)),
//                       SizedBox(
//                         width: 8,
//                       ),
//                       Expanded(
//                           child: MacroCard(
//                               name: "Protein",
//                               count: 65,
//                               unit: "g",
//                               color: Color.fromARGB(255, 215, 86, 67),
//                               icon: Icons.egg_alt)),
//                       SizedBox(
//                         width: 8,
//                       ),
//                       Expanded(
//                           child: MacroCard(
//                               name: "Fat",
//                               count: 23,
//                               unit: "g",
//                               color: Color.fromARGB(255, 211, 91, 120),
//                               icon: Icons.water_drop)),
//                       SizedBox(
//                         width: 8,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 32,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                         child: TextButton(
//                       onPressed: () {},
//                       style: ButtonStyle(
//                           // backgroundColor: MaterialStateProperty.all<Color?>(
//                           //     const Color.fromARGB(255, 6, 174, 213)),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(24.0),
//                             ),
//                           ),
//                           padding:
//                               MaterialStateProperty.all<EdgeInsetsGeometry>(
//                                   const EdgeInsets.symmetric(vertical: 16))),
//                       child: Text(
//                         "DELETE MEAL",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey.shade600),
//                       ),
//                     )),
//                     const SizedBox(
//                       width: 16,
//                     ),
//                     Expanded(
//                         child: TextButton(
//                       onPressed: () {},
//                       style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color?>(
//                               // const Color.fromARGB(255, 6, 174, 213)
//                               Colors.red),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(24.0),
//                             ),
//                           ),
//                           padding:
//                               MaterialStateProperty.all<EdgeInsetsGeometry>(
//                                   const EdgeInsets.symmetric(vertical: 16))),
//                       child: const Text(
//                         "ADD MEAL",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                     )),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ? MacroCard
// class MacroCard extends StatelessWidget {
//   const MacroCard({
//     Key? key,
//     required this.name,
//     required this.count,
//     required this.unit,
//     required this.color,
//     required this.icon,
//   }) : super(key: key);

//   final String name;
//   final int count;
//   final String unit;
//   final Color color;
//   final IconData icon;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: color, width: 1.5)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Icon(
//             icon,
//             color: color,
//             size: 20,
//           ),
//           Text(
//             "$count$unit $name",
//             style: TextStyle(
//                 color: color, fontSize: 12, fontWeight: FontWeight.bold),
//           )
//         ],
//       ),
//     );
//   }
// }

// // ? FoodCard

// class FoodCard extends StatelessWidget {
//   const FoodCard({Key? key, required this.food}) : super(key: key);

//   final Food food;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         // color: Colors.black.withOpacity(0.3),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         elevation: 8,
//         child: ListTile(
//           title: Text(food.name),
//           subtitle: Text(
//             '${food.weight}g',
//             style: const TextStyle(
//                 color: Color.fromARGB(255, 183, 145, 31),
//                 fontWeight: FontWeight.bold),
//           ),
//           trailing: const Text("123 kcal"),
//           onTap: () {},
//         )
//         // Padding(
//         //   padding: const EdgeInsets.all(8.0),
//         //   child: Row(children: [
//         //     Column(
//         //       crossAxisAlignment: CrossAxisAlignment.start,
//         //       children: [
//         //         Text(
//         //           food.name,
//         //           style: const TextStyle(fontWeight: FontWeight.bold),
//         //         ),
//         //         Text(
//         //           '${food.weight} g',
//         //           style: const TextStyle(
//         //             color:Color.fromARGB(255, 183, 145, 31),
//         //             fontWeight: FontWeight.bold),
//         //         )
//         //       ],
//         //     )
//         //   ]),
//         // ),
//         );

//     //   // tileColor: Colors.grey.shade200,

//     // Padding(
//     //   padding: const EdgeInsets.only(bottom: 16),
//     //   child: Container(
//     //     decoration: BoxDecoration(
//     //       color: Colors.white.withOpacity(0.1),
//     //       borderRadius: BorderRadius.circular(8),
//     //     ),
//     //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//     //     child: Row(
//     //       children: [
//     //         Container(
//     //           height: 32,
//     //           width: 32,
//     //           decoration: const BoxDecoration(
//     //             shape: BoxShape.circle,
//     //             gradient: LinearGradient(
//     //               colors: [
//     //                 Colors.red,
//     //                 Colors.deepOrange,
//     //                 // Colors.yellow,
//     //                 // Colors.green,
//     //                 // Colors.blueAccent,
//     //               ],
//     //               begin: Alignment.topLeft,
//     //               end: Alignment.topRight,
//     //             ),
//     //           ),
//     //           padding: const EdgeInsets.all(2),
//     //           child: const CircleAvatar(
//     //             foregroundColor: Colors.white,
//     //             backgroundColor: Colors.black,
//     //             child: Icon(
//     //               Icons.check,
//     //               size: 16,
//     //             ),
//     //           ),
//     //         ),
//     //         Padding(
//     //           padding: const EdgeInsets.symmetric(horizontal: 16),
//     //           child: Column(
//     //             crossAxisAlignment: CrossAxisAlignment.start,
//     //             children: [
//     //               Text(
//     //                 food.name,
//     //                 style: const TextStyle(
//     //                   // color: Colors.white,
//     //                   fontWeight: FontWeight.bold,
//     //                 ),
//     //               ),
//     //               const SizedBox(
//     //                 height: 4,
//     //               ),
//     //               Text(
//     //                 "${food.weight}g",
//     //                 style: const TextStyle(
//     //                   fontWeight: FontWeight.bold,
//     //                   color: Color.fromARGB(255, 183, 145, 31),
//     //                   fontSize: 12,
//     //                 ),
//     //               )
//     //             ],
//     //           ),
//     //         )
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
// }
