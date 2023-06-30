import 'package:flutter/material.dart';
import 'package:health_tracker/ui/screens/auth/about/widgets/gender_picker_widget.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:numberpicker/numberpicker.dart';

class AboutContents {
  final String title;
  final String desc;
  final Widget body;
  // dynamic value;

  AboutContents({required this.title, required this.body, required this.desc});
}

List<AboutContents> contents = [
  AboutContents(
      title: "Tell us about yourself!",
      desc: "To give you a better experience we need\n to know your gender",
      body: const GenderPicker()),
  AboutContents(
    title: "How old are you?",
    desc: "This helps us create your personalized plan",
    body: NumberPicker(
      selectedTextStyle: const TextStyle(color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold),
      minValue: 0,
      maxValue: 140,
      value: 18,
      onChanged: (newValue) {},
    ),
  ),
  AboutContents(
    title: "What's your weight?",
    desc: "You can always change this later",
    body: HorizontalPicker(
      initialPosition: InitialPosition.start,
      minValue: 0,
      maxValue: 500,
      divisions: 1000,
      height: 150,
      onChanged: (newValue) {},
      suffix: 'kg',
      activeItemTextColor: Colors.red,
    ),
  ),
];
