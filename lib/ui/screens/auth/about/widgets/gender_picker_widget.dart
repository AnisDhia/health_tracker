import 'package:flutter/material.dart';

class GenderPicker extends StatefulWidget {
  const GenderPicker({Key? key, /*required this.onChanged*/}) : super(key: key);
  // final Function onChanged;
  @override
  State<GenderPicker> createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: selected == 0 ? Colors.red : Colors.grey,
          child: InkWell(
              onTap: () {
                setState(() {
                  selected = 0;
                });
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.male,
                    size: 50,
                    color: Colors.white,
                  ),
                  Text('Male',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        CircleAvatar(
          radius: 50,
          backgroundColor: selected == 1 ? Colors.red : Colors.grey,
          child: InkWell(
              onTap: () {
                setState(() {
                  selected = 1;
                });
              },
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.female,
                    size: 50,
                    color: Colors.white,
                  ),
                  Text('Female',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              )),
        ),
      ],
    );
  }
}
