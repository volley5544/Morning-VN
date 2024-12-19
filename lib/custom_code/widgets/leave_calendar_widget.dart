// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import 'package:table_calendar/table_calendar.dart';

class LeaveCalendarWidget extends StatefulWidget {
  const LeaveCalendarWidget({
    super.key,
    this.width,
    this.height,
    this.holidaysList,
    this.todayColor,
    this.selectedColor,
    this.selectedTextColor,
    this.currentDate,
  });

  final double? width;
  final double? height;
  final List<String>? holidaysList;
  final Color? todayColor;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final DateTime? currentDate;

  @override
  State<LeaveCalendarWidget> createState() => _LeaveCalendarWidgetState();
}

class _LeaveCalendarWidgetState extends State<LeaveCalendarWidget> {
  DateTime focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width!,
        child: TableCalendar(
          focusedDay: focusDate,
          firstDay: DateTime(2020, 1, 1),
          lastDay: DateTime(2030, 1, 1),
          selectedDayPredicate: (day) {
            // Check if this day is in the list of selected dates
            return FFAppState().selectedDatesList!.any((selectedDay) =>
                selectedDay.year == day.year &&
                selectedDay.month == day.month &&
                selectedDay.day == day.day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              // Toggle date selection
              print('eiei ${FFAppState().selectedDatesList!}');
              print('ee ${FFAppState().selectedDatesList!}');
              print('aa ${focusedDay}');
              if (FFAppState().selectedDatesList.contains(selectedDay)) {
                FFAppState().selectedDatesList!.remove(selectedDay);
                safeSetState(() {});
              } else {
                print('in else');
                FFAppState().selectedDatesList!.add(selectedDay);
                safeSetState(() {});
                print(FFAppState().selectedDatesList);
                print('after else');
              }
              safeSetState(() {});
            });
          },
          onPageChanged: (newFocusedDay) {
            // Update the focused day when the month is changed
            setState(() {
              focusDate = newFocusedDay;
            });
          },
          enabledDayPredicate: (day) {
            // Disable Sundays
            return checkEnebleDateSelected(day, widget.holidaysList);
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            selectedTextStyle: TextStyle(
                color: widget.selectedTextColor != null
                    ? widget.selectedTextColor
                    : Colors.white),
            selectedDecoration: BoxDecoration(
              color: widget.selectedColor != null
                  ? widget.selectedColor
                  : Colors.orange,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              //color: null != null ? Colors.green:Color(0xFFFFCAAA),
              shape: BoxShape.circle,
              border: Border.all(
                  color: widget.todayColor != null
                      ? widget.todayColor!
                      : Color(0xFFFFCAAA),
                  width: 2),
            ),
            todayTextStyle: TextStyle(color: Colors.black),
          ),
          headerVisible: true,
          headerStyle: HeaderStyle(
            formatButtonShowsNext: false,
            titleCentered: false,
            formatButtonVisible: false,
            titleTextFormatter: (date, locale) {
              return DateFormat.yMMMM('en').format(date);
            },
          ),
        ));
  }
}

bool checkEnebleDateSelected(DateTime day, List<String>? holidays) {
  return (day.weekday != DateTime.sunday &&
      (holidays != null
          ? !holidays.contains('${DateFormat('yyyy-MM-dd').format(day)}')
          : true) &&
      DateTime.parse('${DateFormat('yyyy-MM-dd').format(day)}').isAfter(
          DateTime.parse('2024-11-12').add(Duration(
              days:
                  -1)))); //&& DateTime.parse('${DateFormat('yyyy-MM-dd').format(day)}').isAfter(DateTime.parse('2024-11-12'))หลังisAfter คือตัวแปรปาล์ม
}
