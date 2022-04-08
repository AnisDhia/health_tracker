import 'package:flutter/material.dart';

class GoalCard extends StatefulWidget {
  final String title;
  final int value, goal;
  const GoalCard({Key? key, required this.title, required this.value, required this.goal})
      : super(key: key);

  @override
  State<GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      value: 0,
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..addListener(() {
        setState(() {});
      });
    controller.animateTo(widget.value / widget.goal);
  }

  @override
  Widget build(BuildContext context) {
    int percentage = ((widget.value / widget.goal) * 100).toInt();
    return SizedBox(
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "$percentage%",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Text(
                  "${widget.value}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      ),
                ),
                Text(
                  " / ${widget.goal} ${widget.title}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey),
                )
              ],
            ),
            LinearProgressIndicator(
              value: controller.value,
              color: Colors.red,
            ),
            // Container(
            //   height: 8,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Colors.white.withOpacity(0.15),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Row(
            //     children: [
            //       Container(
            //         width: MediaQuery.of(context).size.width / 1.2,
            //         decoration: BoxDecoration(
            //           color: Colors.red,
            //           borderRadius: BorderRadius.circular(8),
            //           gradient: const LinearGradient(
            //             colors: [
            //               Colors.blue,
            //               Colors.green,
            //               Colors.lightGreenAccent,
            //               Colors.yellowAccent,
            //               Colors.orangeAccent,
            //               Colors.deepOrange,
            //               Colors.red,
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
