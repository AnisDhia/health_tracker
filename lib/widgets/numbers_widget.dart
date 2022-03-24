import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '4,8', 'Ranking'),
          buildDevider(),
          buildButton(context, '265', 'Following'),
          buildDevider(),
          buildButton(context, '1025', 'Followers'),
        ],
      ),
    );
  }
  Widget buildDevider() => Container(
    height: 24,
    child: const VerticalDivider(
  
    ),
  );

  Widget buildButton(BuildContext context, String value, String text) => 
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 2,),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],

        ),
      );
}