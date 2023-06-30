import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.color,
      required this.width,
      required this.title,
      required this.func})
      : super(key: key);

  final Color color;
  final double width;
  final String title;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 0.1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        color: color,
      ),
      child: MaterialButton(
        onPressed: func,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(fontSize: 11.sp, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class ButtonWidget extends StatelessWidget {
//   final String text;
//   final VoidCallback onClicked;
  
//   const ButtonWidget({
//     Key? key,
//     required this.text,
//     required this.onClicked, 
//     }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         shape: const StadiumBorder(),
//         onPrimary: Colors.white,
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//       ),
//       child: Text(text),
//       onPressed: onClicked,
//     );
//   }
// }