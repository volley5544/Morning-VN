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
  });

  final double? width;
  final double? height;
  final List<String>? holiday; // Holidays in "YYYY-MM-DD" format
  final Future Function(List<DateTime>? dateList)? onDateSelected;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final Map<DateTime, List<Event>> _holidayEvents;
  late final Set<DateTime> _selectedDates;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

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
    setState(() {
      if (_selectedDates.contains(selectedDay)) {
        _selectedDates.remove(selectedDay);
      } else {
        _selectedDates.add(selectedDay);
      }
    });

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
