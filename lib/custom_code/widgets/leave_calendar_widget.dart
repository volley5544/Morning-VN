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
    this.currentYear,
    this.nextYear,
    this.currentYearSelectableDates = '0',
    this.nextYearSelectableDates = '0',
  });

  final double? width;
  final double? height;
  final List<String>? holidaysList;
  final Color? todayColor;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final DateTime? currentDate;
  final String? currentYear;
  final String? nextYear;
  final String currentYearSelectableDates;
  final String nextYearSelectableDates;

  @override
  State<LeaveCalendarWidget> createState() => _LeaveCalendarWidgetState();
}

class _LeaveCalendarWidgetState extends State<LeaveCalendarWidget> {
  DateTime focusDate = DateTime.now();

  // Helper to calculate currentYear and nextYear
  int get _currentYear =>
      int.tryParse(widget.currentYear ?? DateTime.now().year.toString()) ??
      DateTime.now().year;
  int get _nextYear =>
      int.tryParse(widget.nextYear ?? (_currentYear + 1).toString()) ??
      (_currentYear + 1);

  int get _currentYearSelectableDates =>
      int.tryParse(widget.currentYearSelectableDates) ?? 0;
  int get _nextYearSelectableDates =>
      int.tryParse(widget.nextYearSelectableDates) ?? 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width!,
      child: TableCalendar(
        focusedDay: focusDate,
        firstDay: DateTime(_currentYear, 1, 1),
        lastDay: DateTime(_nextYear, 12, 31),
        selectedDayPredicate: (day) {
          return FFAppState().selectedDatesList!.any((selectedDay) =>
              selectedDay.year == day.year &&
              selectedDay.month == day.month &&
              selectedDay.day == day.day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            final currentYearCount = FFAppState()
                .selectedDatesList!
                .where((date) => date.year == _currentYear)
                .length;
            final nextYearCount = FFAppState()
                .selectedDatesList!
                .where((date) => date.year == _nextYear)
                .length;

            if (FFAppState().selectedDatesList!.contains(selectedDay)) {
              FFAppState().selectedDatesList!.remove(selectedDay);
            } else {
              if (selectedDay.year == _currentYear &&
                  currentYearCount >= _currentYearSelectableDates) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text("You can't select more dates in $_currentYear!"),
                ));
                return;
              }
              if (selectedDay.year == _nextYear &&
                  nextYearCount >= _nextYearSelectableDates) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("You can't select more dates in $_nextYear!"),
                ));
                return;
              }

              FFAppState().selectedDatesList!.add(selectedDay);
            }
            safeSetState(() {});
          });
        },
        onPageChanged: (newFocusedDay) {
          setState(() {
            focusDate = newFocusedDay;
          });
        },
        enabledDayPredicate: (day) {
          return checkEnebleDateSelected(day, widget.holidaysList);
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          selectedTextStyle: TextStyle(
            color: widget.selectedTextColor ?? Colors.white,
          ),
          selectedDecoration: BoxDecoration(
            color: widget.selectedColor ?? Colors.orange,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.todayColor ?? Color(0xFFFFCAAA),
              width: 2,
            ),
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
      ),
    );
  }
}

bool checkEnebleDateSelected(DateTime day, List<String>? holidays) {
  return (day.weekday != DateTime.sunday &&
      (holidays != null
          ? !holidays.contains('${DateFormat('yyyy-MM-dd').format(day)}')
          : true) &&
      DateTime.parse('${DateFormat('yyyy-MM-dd').format(day)}')
          .isAfter(DateTime.parse('2024-11-12').add(Duration(days: -1))));
}
