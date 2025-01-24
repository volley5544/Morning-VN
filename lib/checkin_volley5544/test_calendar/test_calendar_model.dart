import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'test_calendar_widget.dart' show TestCalendarWidget;
import 'package:flutter/material.dart';

class TestCalendarModel extends FlutterFlowModel<TestCalendarWidget> {
  ///  Local state fields for this page.

  List<CalendarDataStruct> holidayDataPage = [];
  void addToHolidayDataPage(CalendarDataStruct item) =>
      holidayDataPage.add(item);
  void removeFromHolidayDataPage(CalendarDataStruct item) =>
      holidayDataPage.remove(item);
  void removeAtIndexFromHolidayDataPage(int index) =>
      holidayDataPage.removeAt(index);
  void insertAtIndexInHolidayDataPage(int index, CalendarDataStruct item) =>
      holidayDataPage.insert(index, item);
  void updateHolidayDataPageAtIndex(
          int index, Function(CalendarDataStruct) updateFn) =>
      holidayDataPage[index] = updateFn(holidayDataPage[index]);

  List<CurrentYearStruct> currentYearDataPage = [];
  void addToCurrentYearDataPage(CurrentYearStruct item) =>
      currentYearDataPage.add(item);
  void removeFromCurrentYearDataPage(CurrentYearStruct item) =>
      currentYearDataPage.remove(item);
  void removeAtIndexFromCurrentYearDataPage(int index) =>
      currentYearDataPage.removeAt(index);
  void insertAtIndexInCurrentYearDataPage(int index, CurrentYearStruct item) =>
      currentYearDataPage.insert(index, item);
  void updateCurrentYearDataPageAtIndex(
          int index, Function(CurrentYearStruct) updateFn) =>
      currentYearDataPage[index] = updateFn(currentYearDataPage[index]);

  List<CurrentYearStruct> nextYearDataPage = [];
  void addToNextYearDataPage(CurrentYearStruct item) =>
      nextYearDataPage.add(item);
  void removeFromNextYearDataPage(CurrentYearStruct item) =>
      nextYearDataPage.remove(item);
  void removeAtIndexFromNextYearDataPage(int index) =>
      nextYearDataPage.removeAt(index);
  void insertAtIndexInNextYearDataPage(int index, CurrentYearStruct item) =>
      nextYearDataPage.insert(index, item);
  void updateNextYearDataPageAtIndex(
          int index, Function(CurrentYearStruct) updateFn) =>
      nextYearDataPage[index] = updateFn(nextYearDataPage[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getLeaveList)] action in testCalendar widget.
  ApiCallResponse? apiResult235;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
