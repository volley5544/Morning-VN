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

import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    super.key,
    this.width,
    this.height,
    this.holiday,
    this.onDateSelected,
    this.currentYear,
    this.nextYear,
    this.currentYearSelectableDates = "0",
    this.nextYearSelectableDates = "0",
  });

  final double? width;
  final double? height;
  final List<String>? holiday; // Holidays in "YYYY-MM-DD" format
  final Future Function(List<DateTime>? dateList)? onDateSelected;
  final String? currentYear; // Allows setting the current year as a String
  final String? nextYear; // Allows setting the next year as a String
  final String currentYearSelectableDates; // String, parsed to int when used
  final String nextYearSelectableDates; // String, parsed to int when used

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final Map<DateTime, List<Event>> _holidayEvents;
  late final Set<DateTime> _selectedDates;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  int get _currentYear =>
      int.tryParse(widget.currentYear ?? '') ?? DateTime.now().year;
  int get _nextYear =>
      int.tryParse(widget.nextYear ?? '') ?? (_currentYear + 1);
  int get _currentYearSelectableDates =>
      int.tryParse(widget.currentYearSelectableDates) ?? 0;
  int get _nextYearSelectableDates =>
      int.tryParse(widget.nextYearSelectableDates) ?? 0;

  @override
  void initState() {
    super.initState();
    _selectedDates = {}; // Initialize empty set
    _holidayEvents = _parseHolidays(widget.holiday);
  }

  /// Parses holiday strings into a map of DateTime to Event
  Map<DateTime, List<Event>> _parseHolidays(List<String>? holidays) {
    if (holidays == null || holidays.isEmpty) return {};
    final Map<DateTime, List<Event>> holidayMap = {};
    for (var holiday in holidays) {
      try {
        final parsedDate = DateTime.parse(holiday);
        holidayMap[
            DateTime.utc(parsedDate.year, parsedDate.month, parsedDate.day)] = [
          Event('Holiday')
        ];
      } catch (e) {
        debugPrint('Invalid holiday format: $holiday');
      }
    }
    return holidayMap;
  }

  /// Toggle selection of a date
  void _onDateSelected(DateTime selectedDay) async {
    final currentYearSelectedCount =
        _selectedDates.where((date) => date.year == _currentYear).length;
    final nextYearSelectedCount =
        _selectedDates.where((date) => date.year == _nextYear).length;

    if (_selectedDates.contains(selectedDay)) {
      setState(() {
        _selectedDates.remove(selectedDay);
      });
    } else {
      if (selectedDay.year == _currentYear &&
          currentYearSelectedCount >= _currentYearSelectableDates) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("You can't select more dates in year $_currentYear")),
        );
        return;
      }
      if (selectedDay.year == _nextYear &&
          nextYearSelectedCount >= _nextYearSelectableDates) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("You can't select more dates in year $_nextYear")),
        );
        return;
      }

      setState(() {
        _selectedDates.add(selectedDay);
      });
    }

    if (widget.onDateSelected != null) {
      await widget.onDateSelected!(
          _selectedDates.isNotEmpty ? _selectedDates.toList() : null);
    }
  }

  /// Get events for a specific day
  List<Event> _getEventsForDay(DateTime day) {
    return _holidayEvents[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  /// Prevent selection of weekends and holidays
  bool _isSelectableDay(DateTime day) {
    // Exclude weekends (Saturday and Sunday)
    if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
      return false;
    }

    // Exclude holidays
    if (_holidayEvents
        .containsKey(DateTime.utc(day.year, day.month, day.day))) {
      return false;
    }

    // Dates are valid otherwise
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: TableCalendar<Event>(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => _selectedDates.contains(day),
        calendarFormat: _calendarFormat,
        eventLoader: _getEventsForDay,
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
          weekendTextStyle: TextStyle(color: Colors.red),
          disabledTextStyle: TextStyle(color: Colors.grey),
          markerDecoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          if (_isSelectableDay(selectedDay)) {
            _onDateSelected(selectedDay);
            setState(() {
              _focusedDay = focusedDay;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("You can't select this day!")),
            );
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        enabledDayPredicate: (day) {
          return _isSelectableDay(day);
        },
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
      ),
    );
  }
}

class Event {
  final String title;

  Event(this.title);

  @override
  String toString() => title;
}
