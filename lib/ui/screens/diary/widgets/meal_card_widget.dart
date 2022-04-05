import 'package:flutter/material.dart';

class DiaryMealCard extends StatefulWidget {
  final String title;

  const DiaryMealCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<DiaryMealCard> createState() => _DiaryMealCardState();
}

class _DiaryMealCardState extends State<DiaryMealCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 540,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // Colors.blue,
              // Colors.green,
              // Colors.lightGreenAccent,
              // Colors.yellowAccent,
              // Colors.orangeAccent,
              Colors.deepOrange,
              Colors.red,
            ],
          ),
        ),
        padding: const EdgeInsets.all(1.5),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            // decoration: BoxDecoration(
            //   color: Theme.of(context).dividerColor.withOpacity(0.05),
            // ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.check,
                      // color: Colors.white,
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        // color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              Theme.of(context).dividerColor.withOpacity(0.1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.refresh,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "REPLACE",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Container(
                              height: 32,
                              width: 32,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.red,
                                    Colors.deepOrange,
                                    // Colors.yellow,
                                    // Colors.green,
                                    // Colors.blueAccent,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              padding: const EdgeInsets.all(2),
                              child: const CircleAvatar(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.check,
                                  size: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Smoking Salmon",
                                    style: TextStyle(
                                      // color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "232g",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 183, 145, 31),
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                )),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 64,
                  child: Row(
                    children: [
                      Expanded(
                          child: _macroCard(
                              "",
                              748,
                              "kcal",
                              const Color.fromARGB(255, 7, 165, 201),
                              Icons.local_fire_department)),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: _macroCard(
                              "Carbs",
                              70,
                              "g",
                              const Color.fromARGB(255, 255, 208, 70),
                              Icons.rice_bowl)),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: _macroCard(
                              "Protein",
                              65,
                              "g",
                              const Color.fromARGB(255, 215, 86, 67),
                              Icons.egg_alt)),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: _macroCard(
                              "Fat",
                              23,
                              "g",
                              const Color.fromARGB(255, 211, 91, 120),
                              Icons.water_drop)),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          // backgroundColor: MaterialStateProperty.all<Color?>(
                          //     const Color.fromARGB(255, 6, 174, 213)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(vertical: 16))),
                      child: Text(
                        "DELETE MEAL",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600),
                      ),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              // const Color.fromARGB(255, 6, 174, 213)
                              Colors.red
                              ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(vertical: 16))),
                      child: const Text(
                        "ADD MEAL",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _macroCard(
      String name, int count, String unit, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 1.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Text(
            "$count$unit $name",
            style: TextStyle(
                color: color, fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
