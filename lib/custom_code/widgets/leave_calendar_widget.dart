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
    this.previousYear,
    this.currentYearSelectableDates = '0',
    this.previousYearSelectableDates = '0',
    this.nextYearSelectableDates = '0',
    this.startdate,
    this.enddate,
  });

  final double? width;
  final double? height;
  final List<String>? holidaysList;
  final Color? todayColor;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final DateTime? currentDate;
  final String? currentYear;
  final String? previousYear;
  final String? nextYear;
  final String currentYearSelectableDates;
  final String previousYearSelectableDates;
  final String nextYearSelectableDates;
  final String? startdate;
  final String? enddate;

  @override
  State<LeaveCalendarWidget> createState() => _LeaveCalendarWidgetState();
}

class _LeaveCalendarWidgetState extends State<LeaveCalendarWidget> {
  DateTime focusDate = DateTime.now();
  String currentYearSelectedDateCount = '0';
  String previousYearSelectedDateCount = '0';
  String nextYearSelectedDateCount = '0';

  // Helper to calculate currentYear and nextYear
  int get _currentYear =>
      int.tryParse(widget.currentYear ?? DateTime.now().year.toString()) ??
      DateTime.now().year;
  int get _nextYear =>
      int.tryParse(widget.nextYear ?? (_currentYear + 1).toString()) ??
      (_currentYear + 1);
  int get _previousYear =>
      int.tryParse(widget.previousYear ?? (_currentYear - 1).toString()) ??
      (_currentYear - 1);

  int get _currentYearSelectableDates =>
      int.tryParse(widget.currentYearSelectableDates) ?? 0;
  int get _nextYearSelectableDates =>
      int.tryParse(widget.nextYearSelectableDates) ?? 0;
  int get _previousYearSelectableDates =>
      int.tryParse(widget.previousYearSelectableDates) ?? 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width!,
      child: Column(
        children: [
          TableCalendar(
            focusedDay: focusDate,
            firstDay: DateTime.parse("2024-01-01"),
            lastDay: DateTime.parse("2030-12-12"),
            selectedDayPredicate: (day) {
              return FFAppState().selectedDatesList!.any((selectedDay) =>
                  selectedDay.year == day.year &&
                  selectedDay.month == day.month &&
                  selectedDay.day == day.day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                print('selected date : ${selectedDay}');
                print('start date : ${widget.startdate!}');
                print('end date : ${widget.enddate!}');
                print(_previousYear);
                print(_previousYearSelectableDates);
                final currentYearCount = FFAppState()
                    .selectedDatesList!
                    .where((date) => date.year == _currentYear)
                    .length;
                final nextYearCount = FFAppState()
                    .selectedDatesList!
                    .where((date) => date.year == _nextYear)
                    .length;
                final previousYearCount = FFAppState()
                    .selectedDatesList!
                    .where((date) => date.year == _previousYear)
                    .length;

                if (FFAppState().selectedDatesList!.contains(selectedDay)) {
                  FFAppState().selectedDatesList!.remove(selectedDay);
                  Map<String, String> countDateSelected =
                      countLeaveDateSelectedByYear(
                          FFAppState().selectedDatesList!,
                          '${_currentYear!}',
                          '${_previousYear!}',
                          '${_nextYear!}')!;
                  currentYearSelectedDateCount =
                      countDateSelected['currentYearSelectedCount']!;
                  previousYearSelectedDateCount =
                      countDateSelected['previousYearSelectedCount']!;
                  nextYearSelectedDateCount =
                      countDateSelected['nextYearSelectedCount']!;
                  print(
                      'Current : ${currentYearSelectedDateCount}\nPrevious : ${previousYearSelectedDateCount}\nNext : ${nextYearSelectedDateCount}');
                } else {
                  if (selectedDay.year == _currentYear &&
                      currentYearCount >= _currentYearSelectableDates) {
                    //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //    content:
                    //        Text("You can't select more dates in $_currentYear!"),
                    //  ));
                    return;
                  }
                  if (selectedDay.year == _nextYear &&
                      nextYearCount >= _nextYearSelectableDates) {
                    //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //    content: Text("You can't select more dates in $_nextYear!"),
                    //  ));
                    return;
                  }
                  if (selectedDay.year == _previousYear &&
                      previousYearCount >= _previousYearSelectableDates) {
                    //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //    content: Text("You can't select more dates in $_nextYear!"),
                    //  ));
                    return;
                  }

                  FFAppState().selectedDatesList!.add(selectedDay);
                  Map<String, String> countDateSelected =
                      countLeaveDateSelectedByYear(
                          FFAppState().selectedDatesList!,
                          '${_currentYear!}',
                          '${_previousYear!}',
                          '${_nextYear!}')!;
                  currentYearSelectedDateCount =
                      countDateSelected['currentYearSelectedCount']!;
                  previousYearSelectedDateCount =
                      countDateSelected['previousYearSelectedCount']!;
                  nextYearSelectedDateCount =
                      countDateSelected['nextYearSelectedCount']!;
                  print(
                      'Current : ${currentYearSelectedDateCount}\nPrevious : ${previousYearSelectedDateCount}\nNext : ${nextYearSelectedDateCount}');
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
              return checkEnebleDateSelected(
                  day,
                  widget.holidaysList,
                  false,
                  DateTime.parse(widget.startdate!),
                  DateTime.parse(widget.enddate!));
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
          Padding(
            padding: EdgeInsets.only(left: 24, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (currentYearSelectedDateCount != '0')
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                            'Current Year Leave Count : ${currentYearSelectedDateCount}'),
                      ],
                    ),
                  ),
                if (previousYearSelectedDateCount != '0')
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                            'Previous Year Leave Count : ${previousYearSelectedDateCount}'),
                      ],
                    ),
                  ),
                if (nextYearSelectedDateCount != '0')
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                            'Next Year Leave Count : ${nextYearSelectedDateCount}'),
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

bool checkEnebleDateSelected(DateTime day, List<String>? holidays,
    bool disableOnlySunday, DateTime startdate, DateTime enddate) {
  return ((disableOnlySunday
          ? day.weekday != DateTime.sunday
          : (day.weekday != DateTime.sunday &&
              day.weekday != DateTime.saturday)) &&
      (holidays != null
          ? !holidays.contains('${DateFormat('yyyy-MM-dd').format(day)}')
          : true) &&
      (day.isAfter(startdate!)) &&
      (day.isBefore(enddate!)));
}
//DateTime.parse('${DateFormat('yyyy-MM-dd').format(day)}')
//               .isAfter(DateTime.parse('2024-11-12').add(Duration(days: -1))))

Map<String, String>? countLeaveDateSelectedByYear(
    List<DateTime>? selectedDateList,
    String? currentYear,
    String? previousYear,
    String? nextYear) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  int currentYearSelectedCount = 0;
  int previousYearSelectedCount = 0;
  int nextYearSelectedCount = 0;

  for (int i = 0; i < selectedDateList!.length; i++) {
    if ('${selectedDateList![i].year}' == currentYear!) {
      currentYearSelectedCount++;
    } else if ('${selectedDateList![i].year}' == previousYear!) {
      previousYearSelectedCount++;
    } else {
      nextYearSelectedCount++;
    }
  }

  return {
    'currentYearSelectedCount': '${currentYearSelectedCount}',
    'previousYearSelectedCount': '${previousYearSelectedCount}',
    'nextYearSelectedCount': '${nextYearSelectedCount}'
  };

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
