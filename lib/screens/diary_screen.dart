import 'package:flutter/material.dart';
import 'package:health_tracker/widgets/drawer_widget.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({ Key? key }) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

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
          TableCalendar(
            firstDay: DateTime.utc(2010,10,16), 
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDate, 
            calendarFormat: _calendarFormat,
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.shade200,
              )
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDate = focusedDay;
            },
            
          ),
          const Text('data'),
        ],
      ),
    );
  }
}