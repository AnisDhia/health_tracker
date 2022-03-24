import 'package:flutter/material.dart';
import 'package:health_tracker/widgets/drawer_widget.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
class DiaryScreen extends StatefulWidget {
  const DiaryScreen({ Key? key }) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  DatePickerController _datePickerController = DatePickerController();

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Diary'), 
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          DatePicker(
            DateTime.now(),
            width: 60,
            height: 80,
            controller: _datePickerController,
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.red,
            selectedTextColor: Colors.white,
            inactiveDates: [
              DateTime.now().add(const Duration(days: 3)),
              DateTime.now().add(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 7))
            ],
            onDateChange: (date) {
              
              setState(() {
                _selectedDate = date;
              });
            },
          )
        ],
      ),
    );
  }
}